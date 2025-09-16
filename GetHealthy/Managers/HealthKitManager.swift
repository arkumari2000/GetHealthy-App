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
    
    func fetchTodayActivities(completion: @escaping ([Activity]) -> Void) {
        let group = DispatchGroup()
        var results: [Activity] = []
        
        // Cycling
        group.enter()
        fetchTodaySum(for: .distanceCycling, unit: .meter()) { value in
            let activity = Activity(activityType: .cycling, data: String(format: "%.2f km", value/1000), activityLabel: "Cycling")
            results.append(activity)
            group.leave()
        }
        // Walking
        group.enter()
        fetchTodaySum(for: .distanceWalkingRunning, unit: .meter()) { value in
            let activity = Activity(activityType: .walking, data: String(format: "%.2f km", value/1000), activityLabel: "Walking")
            results.append(activity)
            group.leave()
        }
        // Running (can use .distanceWalkingRunning or a separate logic if you track running distinctively)
        group.enter()
        fetchTodaySum(for: .distanceWalkingRunning, unit: .meter()) { value in
            let activity = Activity(activityType: .running, data: String(format: "%.2f km", value/1000), activityLabel: "Running")
            results.append(activity)
            group.leave()
        }
        // Energy
        group.enter()
        fetchTodaySum(for: .activeEnergyBurned, unit: .kilocalorie()) { value in
            let activity = Activity(activityType: .energy, data: String(format: "%.0f kcal", value), activityLabel: "Energy")
            results.append(activity)
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(results)
        }
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
