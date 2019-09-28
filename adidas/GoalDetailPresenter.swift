//
// Created by Denys Meloshyn on 28/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

class GoalDetailPresenter {
    private let model: GoalEntity
    private let disposeBag = DisposeBag()
    private weak var view: DetailViewProtocol?
    private let interactor: GoalDetailInteractorProtocol

    init(view: DetailViewProtocol, interactor: GoalDetailInteractorProtocol, model: GoalEntity) {
        self.model = model
        self.view = view
        self.interactor = interactor

        switch (model.type ?? .step) {
        case .step:
            interactor.steps().subscribe { [weak self] event in
                switch event {
                case .success(let value):
                    self?.handleSuccess(value: value)
                case .error(_):
                    self?.handleError()
                }
            }.disposed(by: disposeBag)
        case .walkingDistance,
             .runningDistance:
            interactor.walkingRunning().subscribe { [weak self] event in
                switch event {
                case .success(let value):
                    self?.handleSuccess(value: value)
                case .error(_):
                    self?.handleError()
                }
            }.disposed(by: disposeBag)
        }
    }

    private func handleSuccess(value: Double) {
        guard value > 0, let goal = model.goal else {
            view?.refresh(value: "0%")
            return
        }

        view?.refresh(value: "\(value / Double(goal))%")
    }

    private func handleError() {
        view?.refresh(value: "-")
    }
}
