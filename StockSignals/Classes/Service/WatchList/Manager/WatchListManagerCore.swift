//
//  WatchListManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import RxSwift

final class WatchListManagerCore: WatchListManager {
    enum Constants {
        static let groupsKey = "watch_list_manager_core_groups_key"
    }
}

// MARK: Public
extension WatchListManagerCore {
    // TODO
    func obtainWatchListSignals() -> Single<[WatchListSignal]> {
        WatchListManagerCore.mocks()
//        guard let userToken = SessionManagerCore().getSession()?.userToken else {
//            return .error(SignError.tokenNotFound)
//        }
//
//        let request = GetWatchListSignalsRequest(userToken: userToken)
//
//        return SDKStorage.shared
//            .restApiTransport
//            .callServerApi(requestBody: request)
//            .map { GetWatchListSignalsResponse.map(from: $0) }
    }
    
    func obtainGroups() -> Single<[WatchListGroup]> {
        Single<[WatchListGroup]>.create { event in
            let groups = WatchListManagerCore.getGroups()
            
            event(.success(groups))
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.asyncInstance)
    }
    
    func createGroup(name: String, signals: [WatchListSignal]) -> Single<WatchListGroup> {
        Single<WatchListGroup>.create { event in
            let group = WatchListGroup(id: UUID().uuidString, name: name, signals: signals)
            var groups = WatchListManagerCore.getGroups()
            
            groups.append(group)
            
            WatchListManagerCore.save(groups: groups)
            
            event(.success(group))
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.asyncInstance)
        .do(onSuccess: { group in
            WatchListMediator.shared.notifyAboutCreated(group: group)
        })
    }
    
    func add(signal: WatchListSignal, in group: WatchListGroup) -> Single<WatchListGroup> {
        Single<WatchListGroup>.create { event in
            var signals = group.signals
            signals.append(signal)
            
            let updatedGroup = WatchListGroup(id: group.id,
                                              name: group.name,
                                              signals: signals)
            
            let groups = WatchListManagerCore.getGroups()
            let replacedGroups = WatchListManagerCore.replace(group: updatedGroup, in: groups)
            
            WatchListManagerCore.save(groups: replacedGroups)
            
            event(.success(updatedGroup))
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.asyncInstance)
        .do(onSuccess: { group in
            WatchListMediator.shared.notifyAboutChanged(group: group)
        })
    }
    
    func remove(signal: WatchListSignal, from group: WatchListGroup) -> Single<WatchListGroup> {
        Single<WatchListGroup>.create { event in
            var signals = group.signals
            signals.removeAll(where: { $0 == signal })
            
            let updatedGroup = WatchListGroup(id: group.id,
                                              name: group.name,
                                              signals: signals)
            
            let groups = WatchListManagerCore.getGroups()
            let replacedGroups = WatchListManagerCore.replace(group: updatedGroup, in: groups)
            
            WatchListManagerCore.save(groups: replacedGroups)
            
            event(.success(updatedGroup))
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.asyncInstance)
        .do(onSuccess: { group in
            WatchListMediator.shared.notifyAboutChanged(group: group)
        })
    }
    
    func remove(group: WatchListGroup) -> Single<WatchListGroup> {
        Single<WatchListGroup>.create { event in
            var groups = WatchListManagerCore.getGroups()
            groups.removeAll(where: { $0.id == group.id })
            
            WatchListManagerCore.save(groups: groups)
            
            event(.success(group))
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.asyncInstance)
        .do(onSuccess: { group in
            WatchListMediator.shared.notifyAboutRemoved(group: group)
        })
    }
}

// MARK: Private
private extension WatchListManagerCore {
    static func getGroups() -> [WatchListGroup] {
        guard
            let groupsData = UserDefaults.standard.data(forKey: Constants.groupsKey),
            let groups = try? JSONDecoder().decode([WatchListGroup].self, from: groupsData)
        else {
            return []
        }
        
        return groups
    }
    
    static func save(groups: [WatchListGroup]) {
        guard let data = try? JSONEncoder().encode(groups) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: Constants.groupsKey)
    }
    
    static func replace(group: WatchListGroup, in groups: [WatchListGroup]) -> [WatchListGroup] {
        var copy = groups
        
        guard let index = copy.firstIndex(where: { $0.id == group.id }) else {
            return groups
        }
        
        copy[index] = group
        
        return copy
    }
}

// TODO
extension WatchListManagerCore {
    static func mocks() -> Single<[WatchListSignal]> {
        .just([
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 3.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 73.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 10.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 12.52,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 121.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
            
            WatchListSignal(imageUrl: "https://pbs.twimg.com/profile_images/880293971427155968/O1DampL__400x400.jpg",
                            symbol: "AFRM",
                            company: "Affirm Holding Inc.",
                            price: 122.92,
                            change: 53.99,
                            volume: "35,463,415",
                            peRatio: 53.99,
                            marketCap: "53.99"),
        ])
    }
}
