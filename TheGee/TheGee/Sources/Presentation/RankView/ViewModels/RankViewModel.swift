////
////  RankViewModel.swift
////  TheGee
////
////  Created by Moo on 4/19/25.
////
//
//import Foundation
//import SwiftUI
//
//// MARK: - 랭킹 뷰모델
///// 랭킹 및 개인 기록 데이터를 관리하는 뷰모델
//class RankViewModel: ObservableObject {
//    // MARK: 상태 변수
//    @Published var rankingItems: [RankingItem] = []
//    @Published var personalRecords: [PersonalRecord] = []
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String? = nil
//    
//    // 서비스 의존성
//    private let rankingService: RankingService
//    
//    // 의존성 주입을 통한 초기화
//    init(rankingService: RankingService = RankingService()) {
//        self.rankingService = rankingService
//        loadData()
//    }
//    
//    // MARK: 데이터 로드
//    func loadData() {
//        isLoading = true
//        
//        // 서비스를 통해 데이터 로드
//        rankingItems = rankingService.getRankingItems()
//        personalRecords = rankingService.getPersonalRecords()
//        
//        isLoading = false
//    }
//    
//    // MARK: 기록 저장
//    func saveRecord(reactionTime: Int) {
//        rankingService.savePersonalRecord(reactionTime: reactionTime)
//        // 데이터 갱신
//        personalRecords = rankingService.getPersonalRecords()
//    }
//    
//    // MARK: 기록 삭제
//    func deleteRecord(withId id: UUID) {
//        rankingService.deletePersonalRecord(id: id)
//        // 데이터 갱신
//        personalRecords = rankingService.getPersonalRecords()
//    }
//    
//    // MARK: 날짜 포맷팅
//    func formatDate(_ date: Date) -> String {
//        return rankingService.formatDate(date)
//    }
//    
//    // MARK: 데이터 새로고침
//    func refreshData() {
//        loadData()
//    }
//    
//    // MARK: - 뷰 관련 컴퓨티드 프로퍼티
//    
//    /// 반응 시간 기준 정렬된 랭킹 아이템
//    var sortedByReactionTime: [RankingItem] {
//        rankingItems.sorted { $0.reactionTime < $1.reactionTime }
//    }
//    
//    /// 최근 날짜순 정렬된 개인 기록
//    var sortedByRecentDate: [PersonalRecord] {
//        personalRecords.sorted { $0.date > $1.date }
//    }
//}


import Foundation
import SwiftUI

/// 글로벌 랭킹 데이터를 관리하는 뷰모델
final class RankViewModel: ObservableObject {
    // MARK: - 상태 변수
    
    /// 랭킹 아이템 목록
    @Published var rankingItems: [RankingItem] = []
    
    /// 데이터 로딩 중 여부
    @Published var isLoading: Bool = false
    
    /// 랭킹 데이터 로딩 중 발생한 오류 메시지
    @Published var errorMessage: String? = nil
    
    // MARK: - 서비스 의존성
    
    /// 글로벌 랭킹 관련 서비스
    private let rankingService: RankingService
    
    // MARK: - 초기화
    
    /// 뷰모델 초기화 및 데이터 로드
    /// - Parameter rankingService: 랭킹 서비스 (기본값: 공유 인스턴스)
    init(rankingService: RankingService = RankingService.shared) {
        self.rankingService = rankingService
        loadRankings()
    }
    
    // MARK: - 데이터 로드
    
    /// 랭킹 데이터를 로드합니다
    func loadRankings() {
        isLoading = true
        errorMessage = nil
        
        // 1. 목업 데이터로 초기 UI 채우기
        rankingItems = rankingService.getMockRankingItems()
        
        // 2. 실제 랭킹 데이터 비동기 로드
        rankingService.getRankingItems { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch result {
                case .success(let items):
                    self.rankingItems = items
                    
                case .failure(let error):
                    self.errorMessage = "랭킹을 불러오는데 실패했습니다: \(error.localizedDescription)"
                    // 에러 발생 시 이미 설정된 목업 데이터 유지
                }
            }
        }
    }
    
    /// 데이터를 새로고침합니다
    func refreshData() {
        loadRankings()
    }
    
    // MARK: - 컴퓨티드 프로퍼티
    
    /// 반응 시간 기준으로 정렬된 랭킹 아이템
    var sortedByReactionTime: [RankingItem] {
        rankingItems.sorted { $0.reactionTime < $1.reactionTime }
    }
}
