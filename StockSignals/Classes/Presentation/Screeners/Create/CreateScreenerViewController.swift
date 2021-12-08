//
//  CreateScreenerViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

import UIKit
import RxSwift

final class CreateScreenerViewController: UIViewController {
    lazy var mainView = CreateScreenerView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = CreateScreenerViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sections.drive(onNext: { [weak self] sections in
            self?.mainView.collectionView.setup(sections: sections)
        })
        .disposed(by: disposeBag)
        
        mainView.button.rx.tap.subscribe(onNext: { [weak self] in
            self?.goNext()
        })
        .disposed(by: disposeBag)
        
        mainView.collectionView.vc = self
        mainView.collectionView.mainDelegate = self
        
        csFiltersCollectionDidChange()
        addDiscardItem()
    }
}

// MARK: Make
extension CreateScreenerViewController {
    static func make() -> CreateScreenerViewController {
        let vc = CreateScreenerViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.title = "CreateScreener.Title".localized
        return vc
    }
}

// MARK: ScreenersResultViewController
extension CreateScreenerViewController: ScreenersResultViewControllerDelegate {
    func resultViewControllerDidCreated(filterScreener: FilterScreener) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: CSFiltersCollectionViewDelegate
extension CreateScreenerViewController: CSFiltersCollectionViewDelegate {
    func csFiltersCollectionDidChange() {
        let contains = mainView.collectionView.sections.contains(where: { section -> Bool in
            section.elements.contains(where: { element in
                switch element {
                case .signal(let signal):
                    return signal.isSelected
                case .filter(let filter):
                    return filter.selectedItem != nil
                default:
                    return false
                }
            })
        })
        
        mainView.button.isHidden = !contains
    }
}

// MARK: Private
private extension CreateScreenerViewController {
    func addDiscardItem() {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 62, green: 89, blue: 223))
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .dictionary
        
        let item = UIBarButtonItem()
        item.setTitleTextAttributes(attrs, for: .normal)
        item.title = "CreateScreener.Discard".localized
        navigationItem.rightBarButtonItem = item
        
        item.rx.tap.subscribe(onNext: { [weak self] in
            self?.mainView.collectionView.discard()
        })
        .disposed(by: disposeBag)
    }
    
    func goNext() {
        var items = [Filter.Item]()
        
        mainView.collectionView.sections.forEach { section in
            section.elements.forEach { element in
                switch element {
                case .signal(let signal):
                    if signal.isSelected {
                        items.append(signal.item)
                    }
                case .filter(let filter):
                    if let item = filter.selectedItem {
                        items.append(item)
                    }
                default:
                    return
                }
            }
        }
        
        let vc = ScreenersResultViewController.make(mode: .create, items: items)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
