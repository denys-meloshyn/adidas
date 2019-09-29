//
// Created by Denys Meloshyn on 28/09/2019.
// Copyright (c) 2019 Denys Meloshyn. All rights reserved.
//

import Foundation

import HealthKit
import RxSwift
import RxCocoa

protocol GoalDetailInteractorProtocol: AutoMockable {
    func steps() -> Single<Double>
    func walkingRunning() -> Single<Double>
}

class GoalDetailInteractor: GoalDetailInteractorProtocol {
    func steps() -> Single<Double> {
        getAccess().flatMap { r -> Single<Double> in
            guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                throw Const.InternalError.healthKit
            }

            return self.read(quantityType: stepsQuantityType, unit: HKUnit.count()).observeOn(MainScheduler.instance)
        }
    }

    func walkingRunning() -> Single<Double> {
        getAccess().flatMap { r -> Single<Double> in
            guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
                throw Const.InternalError.healthKit
            }

            return self.read(quantityType: stepsQuantityType, unit: HKUnit.meter()).observeOn(MainScheduler.instance)
        }
    }

    private func read(quantityType: HKQuantityType, unit: HKUnit) -> Single<Double> {
        Single.create { event in
            let healthStore = HKHealthStore()

            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

            let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let result = result, let sum = result.sumQuantity() else {
                    event(.error(Const.InternalError.healthKit))
                    return
                }

                event(.success(sum.doubleValue(for: unit)))
            }

            healthStore.execute(query)
            return Disposables.create()
        }
    }

    private func getAccess() -> Single<Bool> {
        Single.create { event in
            guard HKHealthStore.isHealthDataAvailable(),
                  let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
                  let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
                event(.error(Const.InternalError.healthKit))
                return Disposables.create()
            }

            let healthKitTypesToRead: Set<HKObjectType> = [stepCount, distanceWalkingRunning]

            HKHealthStore().requestAuthorization(toShare: Set(), read: healthKitTypesToRead) { (success, error) in
                event(.success(success))
            }

            return Disposables.create()
        }
    }
}
