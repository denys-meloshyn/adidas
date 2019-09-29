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
