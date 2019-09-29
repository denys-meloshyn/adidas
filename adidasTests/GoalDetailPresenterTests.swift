//
//  GoalDetailPresenterTests.swift
//  adidasTests
//
//  Created by Denys Meloshyn on 29/09/2019.
//  Copyright © 2019 Denys Meloshyn. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import adidas

class GoalDetailPresenterTests: XCTestCase {
    private func builderFailRead(type: GoalEntityType) -> (DetailViewProtocolMock, GoalDetailPresenter) {
        let view = DetailViewProtocolMock()
        let interactor = GoalDetailInteractorProtocolMock()
        interactor.stepsReturnValue = Single<Double>.create { event in
            event(.error(Const.InternalError.healthKit))
            return Disposables.create()
        }
        interactor.walkingRunningReturnValue = Single<Double>.create { event in
            event(.error(Const.InternalError.healthKit))
            return Disposables.create()
        }

        let model = GoalEntity(id: "id", title: "test_title", description: "test_description", type: type, goal: 1000)
        let presenter = GoalDetailPresenter(view: view, interactor: interactor, model: model)

        return (view, presenter)
    }

    func testReadStepsFailed() {
        let (view, _) = builderFailRead(type: .step)
        XCTAssertEqual("-", view.refreshValueReceivedValue)
    }

    func testReadWalkingFailed() {
        let (view, _) = builderFailRead(type: .walkingDistance)
        XCTAssertEqual("-", view.refreshValueReceivedValue)
    }

    func testReadRunningFailed() {
        let (view, _) = builderFailRead(type: .runningDistance)
        XCTAssertEqual("-", view.refreshValueReceivedValue)
    }

    func testFormattingProgress() {
        let view = DetailViewProtocolMock()
        let interactor = GoalDetailInteractorProtocolMock()
        interactor.stepsReturnValue = Single<Double>.create { event in
            event(.success(500))
            return Disposables.create()
        }

        let model = GoalEntity(id: "id", title: "test_title", description: "test_description", type: .step, goal: 1000)
        let _ = GoalDetailPresenter(view: view, interactor: interactor, model: model)
        XCTAssertEqual("0.50%", view.refreshValueReceivedValue)
    }
}
