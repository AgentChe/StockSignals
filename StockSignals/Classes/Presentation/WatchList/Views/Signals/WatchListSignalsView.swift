//
//  WatchListSignalsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit
import RxSwift

protocol WatchListSignalsScrollDelegate: AnyObject {
    func watchListSignalsDidScroll(_ scrollView: UIScrollView)
}

final class WatchListSignalsView: UIView {
    lazy var titlesView = makeTitlesView()
    lazy var tableView = makeTableView()
    
    private lazy var viewModel = WatchListSignalsViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: WatchListSignalsScrollDelegate
extension WatchListSignalsView: WatchListSignalsScrollDelegate {
    func watchListSignalsDidScroll(_ scrollView: UIScrollView) {
        titlesView.scroll(as: scrollView)
        tableView.scroll(as: scrollView)
    }
}

// MARK: Public
extension WatchListSignalsView {
    func viewDidLoad() {
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
    }
}

// MARK: Make constraints
private extension WatchListSignalsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titlesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titlesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titlesView.topAnchor.constraint(equalTo: topAnchor),
            titlesView.heightAnchor.constraint(equalToConstant: 37.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titlesView.bottomAnchor, constant: 32.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WatchListSignalsView {
    func makeTitlesView() -> WatchListSignalsTitlesView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.scale, height: 37.scale)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 32.scale
        layout.headerReferenceSize = CGSize(width: 160.scale, height: 37.scale)
        layout.sectionHeadersPinToVisibleBounds = true
        
        let view = WatchListSignalsTitlesView(frame: .zero, collectionViewLayout: layout)
        view.scrollDelegate = self
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> WatchListSignalsTableView {
        let view = WatchListSignalsTableView()
        view.scrollDelegate = self
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
