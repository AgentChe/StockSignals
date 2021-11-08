//
//  SettingsViewModel.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 08.11.2021.
//

import RxSwift
import RxCocoa

final class SettingsViewModel {
    lazy var pushEnabled = BehaviorRelay<Bool>(value: false)
    
    lazy var elements = makeElements()
    
    private lazy var profileManager = ProfileManagerCore()
}

// MARK: Public
extension SettingsViewModel {
    func send(pushToken: String) -> Single<Void> {
        profileManager
            .set(pushToken: pushToken)
            .catchAndReturn(Void())
    }
}

// MARK: Private
private extension SettingsViewModel {
    func makeElements() -> Driver<[SettingsTableElement]> {
        pushEnabled
            .asDriver()
            .map { pushEnabled -> [SettingsTableElement] in
                var result = [SettingsTableElement]()
                
                if !pushEnabled {
                    result.append(.notifications)
                    result.append(.offset(32.scale))
                }
                
                result.append(.rateApp)
                result.append(.offset(12.scale))
                result.append(.privacyPolicy)
                result.append(.offset(12.scale))
                result.append(.terms)
                result.append(.offset(12.scale))
                result.append(.contactUs)
                
                return result
            }
    }
}
