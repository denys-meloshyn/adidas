//
//  DetailViewController.swift
//  adidas
//
//  Created by Denys Meloshyn on 28/09/2019.
//  Copyright © 2019 Denys Meloshyn. All rights reserved.
//

import UIKit
import HealthKit

class DetailViewController: UIViewController {
    var presenter: GoalDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        let interactor = GoalDetailInteractor()
        presenter = GoalDetailPresenter(interactor: interactor)
    }
}
