//
// Created by Denys Meloshyn on 28/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

class GoalDetailPresenter {
    private let disposeBag = DisposeBag()
    private let interactor: GoalDetailInteractorProtocol

    init(interactor: GoalDetailInteractorProtocol) {
        self.interactor = interactor

        interactor.steps().subscribe { event in

        }.disposed(by: disposeBag)
    }
}
