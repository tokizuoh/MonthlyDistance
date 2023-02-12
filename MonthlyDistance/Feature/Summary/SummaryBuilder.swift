//
//  SummaryBuilder.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

struct SummaryBuilder {
    func build() -> SummaryScreen {
        let viewModel = SummaryViewModel(healthKitClient: HealthKitClient.shared)
        return SummaryScreen(viewModel: viewModel)
    }
}
