//
//  WatchListMediator.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import RxSwift
import RxCocoa

final class WatchListMediator {
    static let shared = WatchListMediator()
    
    private var delegates = [Weak<WatchListMediatorDelegate>]()
    
    private lazy var createdTrigger = PublishRelay<WatchListGroup>()
    private lazy var changedTrigger = PublishRelay<WatchListGroup>()
    private lazy var removedTrigger = PublishRelay<WatchListGroup>()
    
    private init() {}
}

// MARK: Public
extension WatchListMediator {
    func notifyAboutCreated(group: WatchListGroup) {
        DispatchQueue.main.async {
            WatchListMediator.shared.delegates.forEach { $0.weak?.watchListDidCreated(group: group) }
            
            WatchListMediator.shared.createdTrigger.accept(group)
        }
    }
    
    func notifyAboutChanged(group: WatchListGroup) {
        DispatchQueue.main.async {
            WatchListMediator.shared.delegates.forEach { $0.weak?.watchListDidChanged(group: group) }
            
            WatchListMediator.shared.changedTrigger.accept(group)
        }
    }
    
    func notifyAboutRemoved(group: WatchListGroup) {
        DispatchQueue.main.async {
            WatchListMediator.shared.delegates.forEach { $0.weak?.watchListDidRemoved(group: group) }
            
            WatchListMediator.shared.removedTrigger.accept(group)
        }
    }
}

// MARK: Rx
extension WatchListMediator {
    var created: Signal<WatchListGroup> {
        createdTrigger.asSignal()
    }
    
    var changed: Signal<WatchListGroup> {
        changedTrigger.asSignal()
    }
    
    var removed: Signal<WatchListGroup> {
        removedTrigger.asSignal()
    }
}

// MARK: Observer
extension WatchListMediator {
    func add(delegate: WatchListMediatorDelegate) {
        let weakly = delegate as AnyObject
        delegates.append(Weak<WatchListMediatorDelegate>(weakly))
        delegates = delegates.filter { $0.weak != nil }
    }

    func remove(delegate: WatchListMediatorDelegate) {
        if let index = delegates.firstIndex(where: { $0.weak === delegate }) {
            delegates.remove(at: index)
        }
    }
}
