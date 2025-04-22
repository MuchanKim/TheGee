import Foundation
import SwiftUI

/// 개인 기록 데이터를 관리하는 뷰모델
final class PersonalRecordViewModel: ObservableObject {
    // MARK: - 상태 변수
    
    /// 개인 기록 목록
    @Published var records: [PersonalRecord] = []
    
    /// 데이터 로딩 중 여부
    @Published var isLoading: Bool = false
    
    // MARK: - 서비스 의존성
    
    /// 개인 기록 관련 서비스
    private let personalRecordService: PersonalRecordService
    
    // MARK: - 초기화
    
    /// - Parameter personalRecordService: 개인 기록 서비스 (기본값: 공유 인스턴스)
    init(personalRecordService: PersonalRecordService = PersonalRecordService.shared) {
        self.personalRecordService = personalRecordService
        loadRecords()
    }
    
    // MARK: - 데이터 로드
    
    /// 개인 기록 데이터를 로드합니다
    func loadRecords() {
        isLoading = true
        
        // 비동기적으로 데이터 로드 (UI 응답성 향상을 위해)
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let records = self.personalRecordService.getRecords()
            
            DispatchQueue.main.async {
                self.records = records
                self.isLoading = false
            }
        }
    }
    
    // MARK: - 기록 관리
    
    /// 새로운 개인 기록을 저장합니다
    /// - Parameter reactionTime: 반응 시간 (밀리초 단위)
    func saveRecord(reactionTime: Int) {
        personalRecordService.saveRecord(reactionTime: reactionTime)
        loadRecords() // 기록 목록 갱신
    }
    
    /// 특정 ID의 개인 기록을 삭제합니다
    /// - Parameter id: 삭제할 기록의 ID
    func deleteRecord(id: UUID) {
        personalRecordService.deleteRecord(id: id)
        loadRecords() // 기록 목록 갱신
    }
    
    // MARK: - 유틸리티
    
    /// 날짜를 포맷팅합니다
    /// - Parameter date: 포맷팅할 날짜
    /// - Returns: 포맷팅된 문자열
    func formatDate(_ date: Date) -> String {
        return personalRecordService.formatDate(date)
    }
    
    /// 데이터를 새로고침합니다
    func refreshData() {
        loadRecords()
    }
    
    // MARK: - 컴퓨티드 프로퍼티
    
    /// 최근 날짜순으로 정렬된 개인 기록
    var sortedByRecentDate: [PersonalRecord] {
        records.sorted { $0.date > $1.date }
    }
}
