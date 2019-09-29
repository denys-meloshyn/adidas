// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - GoalEntity AutoEquatable
extension GoalEntity: Equatable {}
public func == (lhs: GoalEntity, rhs: GoalEntity) -> Bool {
    guard compareOptionals(lhs: lhs.id, rhs: rhs.id, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.title, rhs: rhs.title, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.description, rhs: rhs.description, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.type, rhs: rhs.type, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.goal, rhs: rhs.goal, compare: ==) else { return false }
    return true
}
// MARK: - GoalListViewModel AutoEquatable
extension GoalListViewModel: Equatable {}
public func == (lhs: GoalListViewModel, rhs: GoalListViewModel) -> Bool {
    guard lhs.title == rhs.title else { return false }
    guard lhs.description == rhs.description else { return false }
    guard lhs.type == rhs.type else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
