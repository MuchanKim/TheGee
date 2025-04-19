//
//  RankingService.swift
//  TheGee
//
//  Created by Moo on 4/25/25.
//

import Foundation

/// 랭킹 관련 기능을 제공하는 서비스 클래스
final class RankingService {
    // MARK: - 프로퍼티
    
    /// 로컬 개인 기록 저장소
    private let personalRecordRepository: PersonalRecordRepository
    
    // MARK: - 초기화
    
    init(personalRecordRepository: PersonalRecordRepository = UserDefaultsRepository.shared) {
        self.personalRecordRepository = personalRecordRepository
    }
    
    // MARK: - 개인 기록 관련 메서드
    
    /// 저장된 개인 기록 목록을 가져옵니다
    func getPersonalRecords() -> [PersonalRecord] {
        return personalRecordRepository.getRecords()
    }
    
    /// 새로운 게임 기록을 저장합니다
    func savePersonalRecord(reactionTime: Int) {
        let newRecord = PersonalRecord(
            reactionTime: reactionTime,
            date: Date()
        )
        
        personalRecordRepository.saveRecord(newRecord)
    }
    
    /// 특정 ID의 기록을 삭제합니다
    func deletePersonalRecord(id: UUID) {
        personalRecordRepository.deleteRecord(id: id)
    }
    
    // MARK: - 랭킹 관련 메서드
    
    /// 랭킹 목록을 가져옵니다 (현재는 목업 데이터)
    func getRankingItems() -> [RankingItem] {
        // 올바른 메서드 이름으로 수정
        return RankingMockData.mockRankingItems()
    }
    
    // MARK: - 헬퍼 메서드
    
    /// 날짜를 포맷팅합니다
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일" // 한국어 형식
        return formatter.string(from: date)
    }
}
