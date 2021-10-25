//
//  WatchListGroupNavItem.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 25.10.2021.
//

import UIKit

final class WatchListGroupNavItem: UIBarButtonItem {
    enum State {
        case edit, done
    }
    
    lazy var state = State.edit {
        didSet {
            update()
        }
    }
}

// MARK: Private
extension WatchListGroupNavItem {
    func inverted() {
        switch state {
        case .edit:
            state = .done
        case .done:
            state = .edit
        }
    }
}

// MARK: Private
private extension WatchListGroupNavItem {
    func update() {
        switch state {
        case .edit:
            title = "WatchList.Groups.Edit".localized
        case .done:
            title = "WatchList.Groups.Done".localized
        }
    }
}
