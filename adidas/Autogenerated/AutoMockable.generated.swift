// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import RxSwift
import RxCocoa














class DetailViewProtocolMock: DetailViewProtocol {

    //MARK: - refresh

    var refreshValueCallsCount = 0
    var refreshValueCalled: Bool {
        return refreshValueCallsCount > 0
    }
    var refreshValueReceivedValue: String?
    var refreshValueReceivedInvocations: [String] = []
    var refreshValueClosure: ((String) -> Void)?

    func refresh(value: String) {
        refreshValueCallsCount += 1
        refreshValueReceivedValue = value
        refreshValueReceivedInvocations.append(value)
        refreshValueClosure?(value)
    }

}
class GoalDetailInteractorProtocolMock: GoalDetailInteractorProtocol {

    //MARK: - steps

    var stepsCallsCount = 0
    var stepsCalled: Bool {
        return stepsCallsCount > 0
    }
    var stepsReturnValue: Single<Double>!
    var stepsClosure: (() -> Single<Double>)?

    func steps() -> Single<Double> {
        stepsCallsCount += 1
        return stepsClosure.map({ $0() }) ?? stepsReturnValue
    }

    //MARK: - walkingRunning

    var walkingRunningCallsCount = 0
    var walkingRunningCalled: Bool {
        return walkingRunningCallsCount > 0
    }
    var walkingRunningReturnValue: Single<Double>!
    var walkingRunningClosure: (() -> Single<Double>)?

    func walkingRunning() -> Single<Double> {
        walkingRunningCallsCount += 1
        return walkingRunningClosure.map({ $0() }) ?? walkingRunningReturnValue
    }

}
class GoalListInteractorProtocolMock: GoalListInteractorProtocol {

    //MARK: - fetchData

    var fetchDataCallsCount = 0
    var fetchDataCalled: Bool {
        return fetchDataCallsCount > 0
    }
    var fetchDataReturnValue: Observable<[GoalEntity]>!
    var fetchDataClosure: (() -> Observable<[GoalEntity]>)?

    func fetchData() -> Observable<[GoalEntity]> {
        fetchDataCallsCount += 1
        return fetchDataClosure.map({ $0() }) ?? fetchDataReturnValue
    }

}
class GoalListPresenterProtocolMock: GoalListPresenterProtocol {

    //MARK: - handleSelection

    var handleSelectionRowCallsCount = 0
    var handleSelectionRowCalled: Bool {
        return handleSelectionRowCallsCount > 0
    }
    var handleSelectionRowReceivedRow: Int?
    var handleSelectionRowReceivedInvocations: [Int] = []
    var handleSelectionRowClosure: ((Int) -> Void)?

    func handleSelection(row: Int) {
        handleSelectionRowCallsCount += 1
        handleSelectionRowReceivedRow = row
        handleSelectionRowReceivedInvocations.append(row)
        handleSelectionRowClosure?(row)
    }

}
class GoalListRouterProtocolMock: GoalListRouterProtocol {

    //MARK: - openDetail

    var openDetailModelCallsCount = 0
    var openDetailModelCalled: Bool {
        return openDetailModelCallsCount > 0
    }
    var openDetailModelReceivedModel: GoalEntity?
    var openDetailModelReceivedInvocations: [GoalEntity] = []
    var openDetailModelClosure: ((GoalEntity) -> Void)?

    func openDetail(model: GoalEntity) {
        openDetailModelCallsCount += 1
        openDetailModelReceivedModel = model
        openDetailModelReceivedInvocations.append(model)
        openDetailModelClosure?(model)
    }

}
class GoalListViewProtocolMock: GoalListViewProtocol {

    //MARK: - refreshData

    var refreshDataItemsCallsCount = 0
    var refreshDataItemsCalled: Bool {
        return refreshDataItemsCallsCount > 0
    }
    var refreshDataItemsReceivedItems: [GoalListViewModel]?
    var refreshDataItemsReceivedInvocations: [[GoalListViewModel]] = []
    var refreshDataItemsClosure: (([GoalListViewModel]) -> Void)?

    func refreshData(items: [GoalListViewModel]) {
        refreshDataItemsCallsCount += 1
        refreshDataItemsReceivedItems = items
        refreshDataItemsReceivedInvocations.append(items)
        refreshDataItemsClosure?(items)
    }

}
