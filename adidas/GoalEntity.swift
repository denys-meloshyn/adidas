//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation
import CoreData

enum GoalEntityType: String, Decodable {
    case step
    case walkingDistance = "walking_distance"
    case runningDistance = "running_distance"
}

struct GoalEntity: Decodable {
    let id: String?
    let title: String?
    let description: String?
    let type: GoalEntityType?
    let goal: Int?
}

extension Goal {
    func configure(with model: GoalEntity) {
        id = model.id
        title = model.title
        descriptionSwift = model.description
        type = model.type?.rawValue
        goal = model.goal.map {
            NSNumber(value: $0)
        }
    }

    func toEntity() -> GoalEntity {
        GoalEntity(id: id,
                   title: title,
                   description: descriptionSwift,
                   type: GoalEntityType.init(rawValue: type ?? ""),
                   goal: goal?.intValue)
    }
}
