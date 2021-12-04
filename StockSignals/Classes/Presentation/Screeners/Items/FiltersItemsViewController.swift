//
//  FiltersItemsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

import UIKit
import RxSwift

final class FiltersItemsViewController: UIViewController {
    lazy var mainView = FiltersItemsView(title: filter.title)
    
    private lazy var disposeBag = DisposeBag()
    
    private let filter: Filter
    private let selectedItem: Filter.Item?
    private let confirm: ((Filter.Item?) -> Void)
    
    private init(filter: Filter, selectedItem: Filter.Item? = nil, confirm: @escaping ((Filter.Item?) -> Void)) {
        self.filter = filter
        self.selectedItem = selectedItem
        self.confirm = confirm
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.discardButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.mainView.tableView.discard()
        })
        .disposed(by: disposeBag)
        
        mainView.confirmButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            
            let element = self.mainView.tableView.elements.first(where: { $0.isSelected })
            let item = element?.item
            
            self.dismiss(animated: true) {
                self.confirm(item)
            }
        })
        .disposed(by: disposeBag)
        
        let elements = filter.items.map { [weak self] item -> FiltersItemsTableElement in
            FiltersItemsTableElement(item: item,
                                     isSelected: self?.selectedItem?.key == item.key)
        }
        
        mainView.tableView.setup(elements: elements)
    }
}

// MARK: Make
extension FiltersItemsViewController {
    static func make(filter: Filter, selectedItem: Filter.Item? = nil, confirm: @escaping ((Filter.Item?) -> Void)) -> FiltersItemsViewController {
        FiltersItemsViewController(filter: filter, selectedItem: selectedItem, confirm: confirm)
    }
}
