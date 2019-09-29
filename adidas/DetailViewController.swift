//
//  DetailViewController.swift
//  adidas
//
//  Created by Denys Meloshyn on 28/09/2019.
//  Copyright © 2019 Denys Meloshyn. All rights reserved.
//

import UIKit
import HealthKit

protocol DetailViewProtocol: class, AutoMockable {
    func refresh(value: String)
}

class DetailViewController: UIViewController, DetailViewProtocol {
    @IBOutlet var progressLabel: UILabel!

    var presenter: GoalDetailPresenter!

    func refresh(value: String) {
        progressLabel.text = value
    }
}
