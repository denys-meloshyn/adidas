//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

class GoalListPresenter {
    private let disposeBag = DisposeBag()
    private weak var view: GoalListViewProtocol?
    private let interactor: GoalListInteractorProtocol

    init(interactor: GoalListInteractorProtocol) {
        self.interactor = interactor

        interactor.fetchData().subscribe { event in
            switch event {
            case .next(let items):
                self.view?.refreshData(items: items.map { entity -> GoalListViewModel in
                    GoalListViewModel(title: entity.title ?? "",
                                      description: entity.description ?? "",
                                      type: entity.type?.rawValue ?? "")
                })

            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}
