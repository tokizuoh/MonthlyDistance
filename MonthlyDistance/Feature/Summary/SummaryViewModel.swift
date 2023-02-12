//
//  SummaryViewModel.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

import HealthKit

final class SummaryViewModel: ObservableObject {
    let healthKitClient: HealthKitClient

    init(healthKitClient: HealthKitClient) {
        self.healthKitClient = healthKitClient
    }

    func onAppear() async {
        await setupHealthKit()
        await fetchHealthKitData()
    }

    private func setupHealthKit() async {
        do {
            try await healthKitClient.requestAuthorization()
        } catch {
            // TODO: Handle Error
        }
    }

    private func fetchHealthKitData() async -> [HKSample]? {
        do {
            let now = Date()
            let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: now)))!
            let healthKitData = try await healthKitClient.fetchData(for: .distanceWalkingRunning, from: startOfMonth, to: now)
            return healthKitData
        } catch {
            // TODO: Handle Error
            fatalError()
        }
    }
}
