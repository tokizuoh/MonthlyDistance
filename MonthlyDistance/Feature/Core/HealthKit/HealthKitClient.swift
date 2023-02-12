//
//  HealthKitClient.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

import HealthKit

final class HealthKitClient {
    static let shared =  HealthKitClient()

    private let healthStore = HKHealthStore()

    private init() {}

    func requestAuthorization() async throws {
        let readTypes = Set([
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
            HKObjectType.workoutType()
        ])

        try await healthStore.requestAuthorization(toShare: Set([]), read: readTypes)
    }
}
