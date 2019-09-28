//
// Created by Denys Meloshyn on 27/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    @IBOutlet var typeView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    func configure(with model: GoalListViewModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        typeView.backgroundColor = model.type
    }
}
