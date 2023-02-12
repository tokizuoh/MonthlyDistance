//
//  HealthKitClient.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

import HealthKit

enum HealthKitDataType {
    enum Workout {
        case walking
        case running
        case cycling
    }

    case distanceWalkingRunning
    case workout(Workout)
}

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

    // TODO: Generalize
    func fetchHKStatistics(for type: HealthKitDataType, from: Date, to: Date) async throws -> HKStatistics? {
        guard case .distanceWalkingRunning = type else {
            return nil
        }

        let quantityType = HKQuantityType(.distanceWalkingRunning)
        let predicate = HKQuery.predicateForSamples(withStart: from, end: to)
        let samplePredicate = HKSamplePredicate.quantitySample(type: quantityType, predicate: predicate)

        let query = HKStatisticsQueryDescriptor(predicate: samplePredicate, options: .cumulativeSum)
        let statistics = try await query.result(for: healthStore)
        return statistics
    }
}
