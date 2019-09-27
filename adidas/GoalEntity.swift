//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

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
