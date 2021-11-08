//
//  WatchListSignalCollectionElement.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

enum WatchListSignalCollectionElement {
    case price(Double)
    case change(Double)
    case volume(String)
    case peRatio(Double?)
    case marketCap(String?)
}
