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

    func fetchData(for type: HealthKitDataType, from: Date, to: Date) async throws -> [HKSample]? {
        guard case .distanceWalkingRunning = type else {
            return nil
        }

        let descriptor = HKSampleQueryDescriptor(
            predicates: [
                .sample(
                    type: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
                    predicate: HKQuery.predicateForSamples(withStart: from, end: to, options: [])
                )
            ],
            sortDescriptors: []
        )

        let samples = try await descriptor.result(for: healthStore)
        return samples
    }
}
