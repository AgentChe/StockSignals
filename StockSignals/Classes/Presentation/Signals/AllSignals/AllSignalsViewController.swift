//
//  AllSignalsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.11.2021.
//

import UIKit
import RxSwift

final class AllSignalsViewController: UIViewController {
    lazy var mainView = AllSignalsView(title: viewTitle)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = AllSignalsViewModel()
    
    private let viewTitle: String
    
    private init(title: String) {
        self.viewTitle = title
        
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
        
        mainView.backButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
        
        mainView.sortButton.rx.tap
            .withLatestFrom(viewModel.sort)
            .subscribe(onNext: { [weak self] sort in
                guard let self = self else {
                    return
                }
            
                self.mainView.sortView.show(selectedSort: sort)
            })
            .disposed(by: disposeBag)
        
        mainView.sortButton.sort = .maxGain
        mainView.sortView.delegate = self
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension AllSignalsViewController {
    static func make(title: String, filter: SignalsFilter, type: SignalType? = nil) -> AllSignalsViewController {
        let vc = AllSignalsViewController(title: title)
        vc.viewModel.type.accept(filter)
        vc.viewModel.activity.accept(type)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: AllSignalsSortViewDelegate
extension AllSignalsViewController: AllSignalsSortViewDelegate {
    func allSignalsDidChange(sort: AllSignalsSort) {
        mainView.sortButton.sort = sort
        viewModel.sort.accept(sort)
    }
}

// MARK: AllSignalsTableViewDelegate
extension AllSignalsViewController: AllSignalsTableViewDelegate {
    func allSignalsTableDidSelect(symbol: String) {
        let vc = DetailsViewController.make(symbol: symbol)
        present(vc, animated: true)
    }
}
