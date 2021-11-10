//
//  AllQuotationsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 10.11.2021.
//

import UIKit
import RxSwift

final class AllQuotationsViewController: UIViewController {
    lazy var mainView = AllQuotationsView(title: viewTitle)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = AllQuotationsViewModel()
    
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
        
        mainView.titlesView.scrollDelegate = self
        mainView.titlesView.mainDelegate = self
        mainView.tableView.scrollDelegate = self
    }
}

// MARK: Make
extension AllQuotationsViewController {
    static func make(title: String, quotations: [Quotation]) -> AllQuotationsViewController {
        let vc = AllQuotationsViewController(title: title)
        vc.viewModel.quotations.accept(quotations)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: WatchListSignalsScrollDelegate
extension AllQuotationsViewController: WatchListSignalsScrollDelegate {
    func watchListSignalsDidScroll(_ scrollView: UIScrollView) {
        mainView.titlesView.scroll(as: scrollView)
        mainView.tableView.scroll(as: scrollView)
    }
}

// MARK: WatchListSignalsTitlesViewDelegate
extension AllQuotationsViewController: WatchListSignalsTitlesViewDelegate {
    func watchListDidSelect(sort: WatchListSignalsSortElement) {
        viewModel.sort.accept(sort)
    }
}
