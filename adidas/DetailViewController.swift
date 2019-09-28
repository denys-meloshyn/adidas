//
//  DetailViewController.swift
//  adidas
//
//  Created by Denys Meloshyn on 28/09/2019.
//  Copyright © 2019 Denys Meloshyn. All rights reserved.
//

import UIKit
import HealthKit

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        guard HKHealthStore.isHealthDataAvailable() else {
          return
        }

        let healthKitTypesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                                       HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        ]
        HKHealthStore().requestAuthorization(toShare: Set(),
                                             read: healthKitTypesToRead) { (success, error) in
            let healthStore = HKHealthStore()

            let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

            let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let result = result, let sum = result.sumQuantity() else {
                    return
                }
                let r = sum.doubleValue(for: HKUnit.count())
            }

            healthStore.execute(query)
        }
    }
}
