//
// Created by Denys Meloshyn on 28/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import UIKit

protocol GoalListRouterProtocol {
    func openDetail(model: GoalEntity)
}

class GoalListRouter: GoalListRouterProtocol {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openDetail(model: GoalEntity) {
        let detailViewController = Coordinator.detail(model)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
