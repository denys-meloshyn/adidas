//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import CoreData

protocol GoalListInteractorProtocol: AutoMockable {
    func fetchData() -> Observable<[GoalEntity]>
}

class GoalListInteractor: GoalListInteractorProtocol {
    private let repository: GoalsRepositoryProtocol

    init(repository: GoalsRepositoryProtocol) {
        self.repository = repository
    }

    func fetchData() -> Observable<[GoalEntity]> {
        Observable.concat([repository.fetchData().asObservable(), repository.loadGoals().asObservable()])
    }
}
