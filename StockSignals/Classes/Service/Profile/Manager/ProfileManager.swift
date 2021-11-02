//
//  ProfileManager.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.11.2021.
//

import RxSwift

protocol ProfileManager {
    func set(pushToken: String) -> Single<Void>
}
