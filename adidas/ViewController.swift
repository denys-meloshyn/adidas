//
//  ViewController.swift
//  adidas
//
//  Created by Denys Meloshyn on 27/09/2019.
//  Copyright © 2019 Denys Meloshyn. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import HTTPNetworking

protocol GoalListViewProtocol: class {
    func refreshData(items: [GoalListViewModel])
}

struct GoalListViewModel {
    let title: String
    let description: String
    let type: String
}

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    let repository = GoalsRepository(manager: GoalsApiManager(httpClient: HTTPNetwork.instance),
                                     managedObjectContext: CoreDataStack.instance.persistentContainer.viewContext)

    override func viewDidLoad() {
        super.viewDidLoad()

        repository.loadGoals().subscribe { event in
        }.disposed(by: disposeBag)
    }
}

