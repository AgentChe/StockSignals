//
//  WatchListSignalsView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit
import RxSwift

final class WatchListSignalsView: UIView {
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
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WatchListSignalsView {
    func makeTableView() -> WatchListSignalsTableView {
        let view = WatchListSignalsTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
