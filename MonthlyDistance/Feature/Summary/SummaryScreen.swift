//
//  SummaryScreen.swift
//  MonthlyDistance
//
//  Created by tokizo on 2023/02/12.
//

import SwiftUI

struct SummaryScreen: View {
    @ObservedObject var viewModel: SummaryViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task(viewModel.onAppear)
    }
}
