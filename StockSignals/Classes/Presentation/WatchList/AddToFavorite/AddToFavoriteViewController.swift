//
//  AddToFavoriteViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 19.11.2021.
//

import UIKit
import RxSwift

final class AddToFavoriteViewController: UIViewController {
    lazy var mainView = AddToFavoriteView()
    
    private lazy var viewModel = AddToFavoriteViewModel(symbol: symbol)
    
    private lazy var disposeBag = DisposeBag()
    
    private let symbol: String
    
    private init(symbol: String) {
        self.symbol = symbol
        
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
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        viewModel.command.emit(onNext: { [weak self] element in
            self?.mainView.tableView.replace(element: element)
        })
        .disposed(by: disposeBag)
        
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension AddToFavoriteViewController {
    static func make(symbol: String) -> AddToFavoriteViewController {
        AddToFavoriteViewController(symbol: symbol)
    }
}

// MARK: AddToFavoriteTableViewDelegate
extension AddToFavoriteViewController: AddToFavoriteTableViewDelegate {
    func addToFavoriteDidSelect(element: AddToFavoriteTableElement) {
        switch element.isFavorite {
        case true:
            viewModel.fromGroup.accept(element.group)
        case false:
            viewModel.inGroup.accept(element.group)
        }
    }
}
