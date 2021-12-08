//
//  ScreenersManagerCore.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import RxSwift

final class ScreenersManagerCore: ScreenersManager {
    enum Constants {
        static let filterScreenersKey = "screeners_manager_core_filter_screeners_key"
    }
}

// MARK: ScreenersManager
extension ScreenersManagerCore {
    func obtainBundle(filters: [FilterScreener]? = nil) -> Single<ScreenersBundle?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }

        let request = GetScreenersBundleRequest(userToken: userToken, filters: filters)

        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetScreenersBundleResponse.map(from: $0, filtersScreeners: filters ?? []) }
    }
    
    func obtainFilters() -> Single<Filters?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetFiltersRequest(userToken: userToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetFiltersResponse.map(from: $0) }
    }
    
    func add(filterScreener: FilterScreener) -> Single<FilterScreener> {
        obtainFilterScreeners().flatMap { cache -> Single<FilterScreener> in
            Single<FilterScreener>.create { event in
                var result = cache
                
                result.append(filterScreener)
                
                if let data = try? JSONEncoder().encode(result) {
                    UserDefaults.standard.set(data, forKey: Constants.filterScreenersKey)
                }
                
                event(.success(filterScreener))
                
                ScreenersMediator.shared.notifyAboutChangedFiltersScreeners()
                
                return Disposables.create()
            }
        }
    }
    
    func delete(filterScreenerId: String) -> Single<Void> {
        obtainFilterScreeners().flatMap { cache -> Single<Void> in
            Single<Void>.create { event in
                var result = cache
                
                result.removeAll(where: { $0.id == filterScreenerId })
                
                if let data = try? JSONEncoder().encode(result) {
                    UserDefaults.standard.set(data, forKey: Constants.filterScreenersKey)
                }
                
                event(.success(Void()))
                
                ScreenersMediator.shared.notifyAboutChangedFiltersScreeners()
                
                return Disposables.create()
            }
        }
    }
    
    func obtainFilterScreeners() -> Single<[FilterScreener]> {
        Single<[FilterScreener]>.create { event in
            guard
                let data = UserDefaults.standard.data(forKey: Constants.filterScreenersKey),
                let items = try? JSONDecoder().decode([FilterScreener].self, from: data)
            else {
                event(.success([]))
                return Disposables.create()
            }
            
            event(.success(items))
            
            return Disposables.create()
        }
    }
}
