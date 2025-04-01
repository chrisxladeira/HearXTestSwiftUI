//
//  ReultsViewModel.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation
class ResultsViewModel: ObservableObject {
    @Published var testScores: [TestScoresModel] = []
    @Published var selectedIndex: Int? = nil

    init() {
        loadDummyData()
    }

    func loadDummyData() {
        testScores = GlobalData.shareData.testResults ?? []
    }

    func resetSelection() {
        selectedIndex = nil
    }
}
