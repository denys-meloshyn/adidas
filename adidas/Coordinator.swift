//
// Created by Denys Meloshyn on 28/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import UIKit

class Coordinator {
    static let storyBoard = UIStoryboard(name: "Main", bundle: nil)

    class func detail(_ model: GoalEntity) -> DetailViewController {
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        let interactor = GoalDetailInteractor()
        detailViewController.presenter = GoalDetailPresenter(view: detailViewController, interactor: interactor, model: model)

        return detailViewController
    }
}
