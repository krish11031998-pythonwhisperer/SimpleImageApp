//
//  TableView+Rx.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base == UITableView {
    
    var didSelectItemDisposable: Disposable {
        base.rx.itemSelected
            .withUnretained(base)
            .subscribe(onNext: { table, index in
                guard let source = table.source else { return }
                source.tableView(table, didSelectRowAt: index)
                
            })
    }
}

//MARK: - TableView + LoadNextPage
extension Reactive where Base: UIScrollView {
    
    var loadNextPage: Observable<Bool> {
        base.rx.contentOffset
            .withUnretained(base)
            .map { scrollView, offset in
                let height = scrollView.contentSize.height
                guard height >= UIScreen.main.bounds.height else { return false }
                let state = (height - offset.y) <= UIScreen.main.bounds.height * 1.1
                return state
            }
            .asObservable()
    }
    
}
