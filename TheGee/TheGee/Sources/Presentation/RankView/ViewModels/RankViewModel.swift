//
//  RankViewModel.swift
//  TheGee
//
//  Created by Moo on 4/19/25.
//

import Foundation
import SwiftUI

// MARK: - 랭킹 뷰모델
/// 랭킹 및 개인 기록 데이터를 관리하는 뷰모델
class RankViewModel: ObservableObject {
    // MARK: 상태 변수
    @Published var rankingItems: [RankingItem] = []
    @Published var personalRecords: [PersonalRecord] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: 초기화
    init() {
        // 목 데이터 로드
        loadMockData()
    }
    
    // MARK: 목 데이터 로드
    /// 테스트 및 UI 개발용 목 데이터 로드
    private func loadMockData() {
        isLoading = true
        
        // 네트워크 지연 시뮬레이션 (실제 앱에서는 API 호출로 대체)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.rankingItems = RankingMockData.mockRankingItems()
            self.personalRecords = RankingMockData.mockPersonalRecords()
            self.isLoading = false
        }
    }
    
    // MARK: 개인 기록 삭제
    /// 특정 인덱스의 개인 기록 삭제
    /// - Parameter index: 삭제할 기록의 인덱스
    func deletePersonalRecord(at index: Int) {
        guard index < personalRecords.count else { return }
        personalRecords.remove(at: index)
    }
    
    // MARK: 날짜 포맷팅
    /// 날짜를 지정된 형식의 문자열로 변환
    /// - Parameter date: 변환할 Date 객체
    /// - Returns: "M월 d일" 형식의 문자열
    func formattedDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일" // 한국어 형식으로 변경
        return formatter.string(from: date)
    }
}

// MARK: - 데이터 처리 확장
extension RankViewModel {
    /// ID로 개인 기록 삭제
    func deletePersonalRecord(withId id: UUID) {
        guard let index = personalRecords.firstIndex(where: { $0.id == id }) else { return }
        deletePersonalRecord(at: index)
    }
    
    /// 반응 시간 기준 정렬된 랭킹 아이템
    var sortedByReactionTime: [RankingItem] {
        rankingItems.sorted { $0.reactionTime < $1.reactionTime }
    }
    
    /// 최근 날짜순 정렬된 개인 기록
    var sortedByRecentDate: [PersonalRecord] {
        personalRecords.sorted { $0.date > $1.date }
    }
    
    /// 랭킹 데이터 새로고침
    func refreshData() {
        loadMockData()
    }
}