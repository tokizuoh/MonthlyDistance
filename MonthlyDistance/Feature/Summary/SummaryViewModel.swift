//
//  SummaryViewModel.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

import HealthKit

final class SummaryViewModel: ObservableObject {
    // TODO: Value
    @Published var state: ScreenState<String, Error> = .loading

    let healthKitClient: HealthKitClient

    init(healthKitClient: HealthKitClient) {
        self.healthKitClient = healthKitClient
    }

    func onAppear() async {
        do {
            try await setupHealthKit()
            _ = try await fetchStatistics()
            // TODO: Shape and dispatch to View
        } catch {
            state = .failed(error)
        }
    }

    private func setupHealthKit() async throws {
        try await healthKitClient.requestAuthorization()
    }

    private func fetchStatistics() async throws -> HKStatistics? {
        let now = Date()
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: now)))!
        let healthKitData = try await healthKitClient.fetchHKStatistics(for: .distanceWalkingRunning, from: startOfMonth, to: now)
        return healthKitData
    }
}
