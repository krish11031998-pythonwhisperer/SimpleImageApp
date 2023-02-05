//
//  TableView+Rx.swift
//  VuzAssessment
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
                //print("(DEBUG) height: ", height)
                //print("(DEBUG) offset: ", offset.y)
                let state = (height - offset.y) <= UIScreen.main.bounds.height
                //print("(DEBUG) state: ", state)
                return state
            }
            .asObservable()
    }
    
//    var loadNextPage: Observable<Bool> {
//
//        base.rx.contentOffset
//            .asObservable()
//            .withUnretained(base)
//            .map { base, offset in
//                let height = base.contentSize.height
//                print("(DEBUG) height: ", height)
//                print("(DEBUG) offset: ", offset.y)
//                return (height - offset.y) == UIScreen.main.bounds.height * 1.05
//            }
//            .asObservable()
//    }
    
    
}
