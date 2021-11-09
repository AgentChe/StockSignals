//
//  SignalsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.11.2021.
//

import UIKit
import RxSwift

final class SignalsViewController: UIViewController {
    lazy var mainView = SignalsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SignalsViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        viewModel.selectedAllSignals.drive(onNext: { [weak self] bundle in
            let vc = AllSignalsViewController.make(type: bundle.type,
                                                   stockSignals: bundle.stockSignals,
                                                   optionCryptoSignals: bundle.optionCryptoSignals)
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        addFilterActions()
        addNavBarItems()
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension SignalsViewController {
    static func make() -> SignalsViewController {
        let vc = SignalsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: SignalsTableViewDelegate
extension SignalsViewController: SignalsTableViewDelegate {
    func signalsTableViewDidSelect(element: SignalsTableElement) {
        switch element {
        case .type(let type):
            viewModel.didSelectAllSignals.accept(type.type)
        case .stock(let signal):
            // TODO
            break
        case .optionCrypto(let signal):
            // TODO
            break
        default:
            break
        }
    }
}

// MARK: Private
private extension SignalsViewController {
    func addFilterActions() {
        Observable
            .merge(
                mainView.filterView.stockButton
                    .rx.tap
                    .map { _ in SignalsFilter.stock },
                
                mainView.filterView.optionButton
                    .rx.tap
                    .map { _ in SignalsFilter.option },
                
                mainView.filterView.cryptoButton
                    .rx.tap
                    .map { _ in SignalsFilter.crypto }
            )
            .startWith(.stock)
            .subscribe(onNext: { [weak self] filter in
                self?.viewModel.filter.accept(filter)
                self?.mainView.filterView.type = filter
            })
            .disposed(by: disposeBag)
    }
    
    func addNavBarItems() {
        let settingstem = UIBarButtonItem()
        settingstem.image = UIImage(named: "Signals.Settings")
        
        let searchtem = UIBarButtonItem()
        searchtem.image = UIImage(named: "Signals.Search")
        
        navigationItem.rightBarButtonItems = [settingstem, searchtem]
        
        settingstem.rx.tap.subscribe(onNext: { [weak self] in
            let vc = SettingsViewController.make()
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        searchtem.rx.tap.subscribe(onNext: { [weak self] in
            let vc = SearchViewController.make()
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
    }
}
