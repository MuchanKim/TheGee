import Foundation

/// 개인 기록 관련 기능을 제공하는 서비스 클래스
final class PersonalRecordService {
    // MARK: - 프로퍼티
    
    /// 로컬 개인 기록 저장소
    private let repository: PersonalRecordRepository
    
    // MARK: - 초기화
    
    /// PersonalRecordService 인스턴스를 초기화합니다.
    /// - Parameter repository: 개인 기록 저장소 (기본값: UserDefaultsRepository.shared)
    init(repository: PersonalRecordRepository = UserDefaultsRepository.shared) {
        self.repository = repository
    }
    
    // MARK: - 공유 인스턴스
    
    /// PersonalRecordService의 공유 인스턴스
    static let shared = PersonalRecordService()
    
    // MARK: - 메서드
    
    /// 저장된 개인 기록 목록을 모두 가져옵니다.
    /// - Returns: 개인 기록 배열 (최신순 정렬)
    func getRecords() -> [PersonalRecord] {
        return repository.getRecords()
    }
    
    /// 새로운 게임 기록을 저장합니다.
    /// - Parameter reactionTime: 게임에서 측정된 반응 시간 (밀리초 단위)
    func saveRecord(reactionTime: Int) {
        let newRecord = PersonalRecord(
            reactionTime: reactionTime,
            date: Date()
        )
        
        repository.saveRecord(newRecord)
    }
    
    /// 특정 ID의 개인 기록을 삭제합니다.
    /// - Parameter id: 삭제할 기록의 고유 ID
    func deleteRecord(id: UUID) {
        repository.deleteRecord(id: id)
    }
    
    /// 날짜를 한국어 형식으로 포맷팅합니다.
    /// - Parameter date: 포맷팅할 날짜
    /// - Returns: "M월 d일" 형식의 문자열 (예: "4월 21일")
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일" // 한국어 형식
        return formatter.string(from: date)
    }
}
