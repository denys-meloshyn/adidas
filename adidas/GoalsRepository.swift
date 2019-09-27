//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import CoreData

protocol GoalsRepositoryProtocol {
    func loadGoals() -> Single<[GoalEntity]>
    func fetchData() -> Single<[GoalEntity]>
}

class GoalsRepository: GoalsRepositoryProtocol {
    private let manager: GoalsApiManagerProtocol
    private let managedObjectContext: NSManagedObjectContext

    init(manager: GoalsApiManagerProtocol, managedObjectContext: NSManagedObjectContext) {
        self.manager = manager
        self.managedObjectContext = managedObjectContext
    }

    func fetchData() -> Single<[GoalEntity]> {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        do {
            let items = try managedObjectContext.fetch(fetchRequest)
            return Single.just(items.map {
                $0.toEntity()
            })
        } catch {
            return Single.just([])
        }
    }

    func loadGoals() -> Single<[GoalEntity]> {
        manager.loadGoals().map { [weak self] entities -> [GoalEntity] in
            guard let managedObjectContext = self?.managedObjectContext else {
                return []
            }

            for model in entities {
                guard let id = model.id else {
                    continue
                }

                let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id = %@", id)
                fetchRequest.fetchBatchSize = 1

                let items = try managedObjectContext.fetch(fetchRequest)
                let goal: Goal
                if items.isEmpty {
                    goal = Goal(context: managedObjectContext)
                } else {
                    goal = items[0]
                }

                goal.configure(with: model)
            }

            CoreDataStack.instance.saveContext()

            return entities
        }
    }
}
