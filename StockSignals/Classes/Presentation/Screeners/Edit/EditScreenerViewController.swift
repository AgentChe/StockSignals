//
//  EditScreenerViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 08.12.2021.
//

import UIKit
import RxSwift

protocol EditScreenerViewControllerDelegate: AnyObject {
    func editScreenerDidEdited(filterScreener: FilterScreener)
}

final class EditScreenerViewController: UIViewController {
    weak var delegate: EditScreenerViewControllerDelegate?
    
    lazy var mainView = CreateScreenerView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = EditScreenerViewModel(filterScreener: filterScreener)
    
    private weak var parentVC: UIViewController?
    private let filterScreener: FilterScreener
    
    private init(parentVC: UIViewController?, filterScreener: FilterScreener) {
        self.parentVC = parentVC
        self.filterScreener = filterScreener
        
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
        
        viewModel.sections.drive(onNext: { [weak self] sections in
            self?.mainView.collectionView.setup(sections: sections)
            self?.csFiltersCollectionDidChange()
        })
        .disposed(by: disposeBag)
        
        mainView.button.rx.tap.subscribe(onNext: { [weak self] in
            self?.goNext()
        })
        .disposed(by: disposeBag)
        
        mainView.collectionView.vc = self
        mainView.collectionView.mainDelegate = self
        
        addDiscardItem()
    }
}

// MARK: Make
extension EditScreenerViewController {
    static func make(parentVC: UIViewController?, filterScreener: FilterScreener) -> EditScreenerViewController {
        let vc = EditScreenerViewController(parentVC: parentVC, filterScreener: filterScreener)
        vc.navigationItem.backButtonTitle = " "
        vc.title = "CreateScreener.Title".localized
        return vc
    }
}

// MARK: ScreenersResultViewControllerDelegate
extension EditScreenerViewController: ScreenersResultViewControllerDelegate {
    func resultViewControllerDidCreated(filterScreener: FilterScreener) {
        delegate?.editScreenerDidEdited(filterScreener: filterScreener)
        
        if let parentVC = parentVC {
            navigationController?.popToViewController(parentVC, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: CSFiltersCollectionViewDelegate
extension EditScreenerViewController: CSFiltersCollectionViewDelegate {
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
private extension EditScreenerViewController {
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
        
        let vc = ScreenersResultViewController.make(mode: .edit(filterScreener), items: items)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
