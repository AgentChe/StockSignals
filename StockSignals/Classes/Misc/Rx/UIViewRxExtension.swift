//
//  UIViewRxExtension.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    var keyboardFrame: Observable<CGRect> {
        return Observable
            .from([
                NotificationCenter.default.rx
                    .notification(UIApplication.keyboardWillShowNotification)
                    .map { notification -> CGRect in
                        return (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
                    },
                
                NotificationCenter.default.rx
                    .notification(UIApplication.keyboardWillHideNotification)
                    .map { notification -> CGRect in
                        return .zero
                    }
            ])
            .merge()
            .distinctUntilChanged()
    }
    
    var hideKeyboardObserver: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
