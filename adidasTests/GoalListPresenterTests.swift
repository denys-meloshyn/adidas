//
// Created by Denys Meloshyn on 29/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import adidas

class GoalListPresenterTests: XCTestCase {
    func testFetchApiFailed() {
        let view = GoalListViewProtocolMock()
        let router = GoalListRouterProtocolMock()
        let interactor = GoalListInteractorProtocolMock()
        interactor.fetchDataReturnValue = Single<[GoalEntity]>.create { event in
            event(.error(Const.InternalError.responseNotValid))
            return Disposables.create()
        }.asObservable()

        _ = GoalListPresenter(interactor: interactor,
                              view: view,
                              router: router)
        XCTAssertEqual(0, view.refreshDataItemsCallsCount)
    }

    func testFetchApiResponseEmpty() {
        let view = GoalListViewProtocolMock()
        let router = GoalListRouterProtocolMock()
        let interactor = GoalListInteractorProtocolMock()
        interactor.fetchDataReturnValue = Single<[GoalEntity]>.create { event in
            event(.success([]))
            return Disposables.create()
        }.asObservable()

        _ = GoalListPresenter(interactor: interactor,
                              view: view,
                              router: router)
        XCTAssertEqual(1, view.refreshDataItemsCallsCount)
        XCTAssertEqual([], view.refreshDataItemsReceivedItems!)
    }
    
    func testFetchApiResponseNotEmpty() {
        let view = GoalListViewProtocolMock()
        let router = GoalListRouterProtocolMock()
        let interactor = GoalListInteractorProtocolMock()
        interactor.fetchDataReturnValue = Single<[GoalEntity]>.create { event in
            let model = GoalEntity(id: "test",
                                   title: "test_title",
                                   description: "test_description",
                                   type: .runningDistance,
                                   goal: 1000)
            event(.success([model]))
            return Disposables.create()
        }.asObservable()

        _ = GoalListPresenter(interactor: interactor,
                              view: view,
                              router: router)
        XCTAssertEqual(1, view.refreshDataItemsCallsCount)
        
        let viewModel = GoalListViewModel(title: "test_title",
                                          description: "test_description",
                                          type: .purple)
        XCTAssertEqual([viewModel], view.refreshDataItemsReceivedItems!)
    }
}
