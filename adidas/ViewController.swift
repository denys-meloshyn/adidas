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
    let type: UIColor
}

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var items = [GoalListViewModel]()
    var presenter: GoalListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        let manager = GoalsApiManager(httpClient: HTTPNetwork.instance)
        let repository = GoalsRepository(manager: manager, managedObjectContext: CoreDataStack.instance.persistentContainer.viewContext)
        let interactor = GoalListInteractor(repository: repository)
        let router = GoalListRouter(viewController: self)
        presenter = GoalListPresenter(interactor: interactor, view: self, router: router)
    }
}

extension ViewController: GoalListViewProtocol {
    func refreshData(items: [GoalListViewModel]) {
        self.items = items
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as! GoalCell
        cell.configure(with: items[indexPath.row])

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.handleSelection(row: indexPath.row)
    }
}
