//
//  RankingModels.swift
//  TheGee
//
//  Created by Moo on 4/19/25.
//

import Foundation
import SwiftUI

// MARK: - 랭킹 아이템 모델
/// 랭킹 리스트에 표시될 각 항목의 데이터 모델
struct RankingItem: Identifiable {
    let id = UUID()
    let rank: Int
    let nickname: String
    let reactionTime: Int // ms 단위
    let iconNumber: Int // 아이콘 번호 (1~5)
}

// MARK: - UI 관련 확장
extension RankingItem {
    /// 랭킹 순위에 따른 색상 반환
    var rankColor: Color {
        switch rank {
        case 1: return Color(UIColor(red: 0.85, green: 0.7, blue: 0.0, alpha: 1.0)) // 금메달 (어두운 노랑)
        case 2: return Color(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)) // 은메달 (어두운 회색)
        case 3: return Color(UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)) // 동메달 (갈색)
        case 4: return Color(UIColor(red: 0.5, green: 0.2, blue: 0.2, alpha: 1.0)) // 4위 (와인색)
        case 5: return Color(UIColor(red: 0.4, green: 0.1, blue: 0.4, alpha: 1.0)) // 5위 (보라색)
        default: return Color.black // 기타
        }
    }
    
    /// 반응 시간 포맷팅된 문자열
    var formattedReactionTime: String {
        return "\(reactionTime) ms"
    }
}

// MARK: - 개인 기록 모델
/// 개인 기록 리스트에 표시될 각 항목의 데이터 모델
struct PersonalRecord: Identifiable, Codable {
    let id: UUID
    let reactionTime: Int
    let date: Date
    
    init(id: UUID = UUID(), reactionTime: Int, date: Date) {
        self.id = id
        self.reactionTime = reactionTime
        self.date = date
    }
    
    // 이전 초기화자 추가
    init(reactionTime: Int, date: Date) {
        self.id = UUID()
        self.reactionTime = reactionTime
        self.date = date
    }
}

// MARK: - UI 관련 확장
extension PersonalRecord {
    /// 반응 시간 포맷팅된 문자열
    var formattedReactionTime: String {
        return "\(reactionTime)ms"
    }
}
