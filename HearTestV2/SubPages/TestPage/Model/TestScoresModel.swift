//
//  TestScoresModel.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation
struct TestScoresData: Codable {
    var data : [TestScoresModel]?
}

// MARK: - Welcome
struct TestScoresModel: Codable {
    var score: Int?
    var rounds: [Round]?
}

// MARK: - Round
struct Round: Codable {
    var difficulty: Int
    var tripletPlayed, tripletAnswered: String

    enum CodingKeys: String, CodingKey {
        case difficulty
        case tripletPlayed = "triplet_played"
        case tripletAnswered = "triplet_answered"
    }
}
