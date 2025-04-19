//
//  RankingMockData.swift
//  TheGee
//
//  Created by Moo on 4/19/25.
//

import Foundation

/// 테스트 및 UI 개발용 목 데이터를 제공
struct RankingMockData {
    
    // MARK: 랭킹 목 데이터
    /// 랭킹 화면에 표시할 목 데이터 생성
    static func mockRankingItems() -> [RankingItem] {
        return [
            RankingItem(rank: 1, nickname: "Moo", reactionTime: 16, iconNumber: 1),
            RankingItem(rank: 2, nickname: "Voo", reactionTime: 22, iconNumber: 2),
            RankingItem(rank: 3, nickname: "Boo", reactionTime: 32, iconNumber: 3),
            RankingItem(rank: 4, nickname: "Qoo", reactionTime: 42, iconNumber: 4),
            RankingItem(rank: 5, nickname: "Zoo", reactionTime: 52, iconNumber: 5)
        ]
    }
    
    // MARK: 개인 기록 목 데이터
    /// 개인 기록 화면에 표시할 목 데이터 생성
    static func mockPersonalRecords() -> [PersonalRecord] {
        let today = Date()
        return [
            PersonalRecord(id: UUID(), reactionTime: 32, date: today),
            PersonalRecord(id: UUID(), reactionTime: 34, date: today),
            PersonalRecord(id: UUID(), reactionTime: 71, date: today)
        ]
    }
}
