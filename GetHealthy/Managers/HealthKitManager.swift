//
//  HealthKitManager.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import Foundation
import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()
    private init() {}

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }
        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        ]
        healthStore.requestAuthorization(toShare: [], read: readTypes, completion: completion)
    }

    func fetchTodaySum(for identifier: HKQuantityTypeIdentifier, unit: HKUnit, completion: @escaping (Double) -> Void) {
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            completion(0)
            return
        }
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now)
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            let value = result?.sumQuantity()?.doubleValue(for: unit) ?? 0
            completion(value)
        }
        healthStore.execute(query)
    }
}
