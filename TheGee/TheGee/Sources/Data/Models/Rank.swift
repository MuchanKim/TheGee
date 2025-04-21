//
//  RankingModels.swift
//  TheGee
//
//  Created by Moo on 4/19/25.
//

import Foundation
import FirebaseCore
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
        return "\(reactionTime)ms"
    }
}

// MARK: - Firebase 랭킹 모델
/// Firestore에 저장되고 불러오는 랭킹 데이터 모델
struct Rank: Identifiable {
    let id: String        // Firestore 문서 ID
    let nickname: String
    let reactionTime: Int
    let createdAt: Date?
    
    // Firestore 문서에서 변환
    init?(documentID: String, data: [String: Any]) {
        guard 
            let nickname = data["nickname"] as? String,
            let reactionTime = data["reactionTime"] as? Int
        else {
            return nil
        }
        
        self.id = documentID
        self.nickname = nickname
        self.reactionTime = reactionTime
        self.createdAt = (data["createdAt"] as? Timestamp)?.dateValue()
    }
}

// MARK: - UI 관련 확장
extension Rank {
    /// 반응 시간 포맷팅된 문자열
    var formattedReactionTime: String {
        return "\(reactionTime)ms"
    }
    
    /// RankingItem으로 변환 (UI 표시용)
    func toRankingItem(rank: Int) -> RankingItem {
        return RankingItem(
            rank: rank,
            nickname: nickname,
            reactionTime: reactionTime,
            iconNumber: (rank <= 5) ? rank : 5  // 1~5위까지는 순위별 아이콘, 나머지는 5번 아이콘
        )
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
