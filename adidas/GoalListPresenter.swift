//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

protocol GoalListPresenterProtocol {
    func handleSelection(row: Int)
}

class GoalListPresenter: GoalListPresenterProtocol {
    private var items = [GoalEntity]()
    private let disposeBag = DisposeBag()
    private let router: GoalListRouterProtocol
    private weak var view: GoalListViewProtocol?
    private let interactor: GoalListInteractorProtocol

    init(interactor: GoalListInteractorProtocol, view: GoalListViewProtocol, router: GoalListRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor

        interactor.fetchData().subscribe { [weak self] event in
            switch event {
            case .next(let items):
                self?.items = items
                self?.view?.refreshData(items: items.map { entity -> GoalListViewModel in
                    let color: UIColor
                    switch (entity.type ?? .step) {
                    case .step:
                        color = .orange
                    case .walkingDistance:
                        color = .green
                    case .runningDistance:
                        color = .purple
                    }

                    return GoalListViewModel(title: entity.title ?? "",
                                             description: entity.description ?? "",
                                             type: color)
                })

            default:
                break
            }
        }.disposed(by: disposeBag)
    }

    func handleSelection(row: Int) {
        router.openDetail(model: items[row])
    }
}
