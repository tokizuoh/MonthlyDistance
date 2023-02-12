//
//  SummaryViewModel.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

import Foundation

final class SummaryViewModel: ObservableObject {
    let healthKitClient: HealthKitClient

    init(healthKitClient: HealthKitClient) {
        self.healthKitClient = healthKitClient
    }

    func onAppear() async {
        await setupHealthKit()
    }

    private func setupHealthKit() async {
        do {
            try await healthKitClient.requestAuthorization()
        } catch {
            // TODO: Handle Error
        }
    }
}
