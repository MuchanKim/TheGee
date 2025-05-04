import Foundation

/// UserDefaults를 이용한 저장소 구현체
class UserDefaultsRepository: PersonalRecordRepository {
    private let recordsKey: String
    private let maxRecords: Int
    private let userDefaults: UserDefaults
    
    // MARK: - 초기화
    
    /// 기본 초기화 메서드
    /// - Parameters:
    ///   - recordsKey: UserDefaults에 저장될 키 (기본값: "personalRecords")
    ///   - maxRecords: 최대 저장 기록 수 (기본값: 3)
    ///   - userDefaults: 사용할 UserDefaults 인스턴스 (기본값: standard)
    init(
        recordsKey: String = "personalRecords",
        maxRecords: Int = 3,
        userDefaults: UserDefaults = .standard
    ) {
        self.recordsKey = recordsKey
        self.maxRecords = maxRecords
        self.userDefaults = userDefaults
    }
    
    func getRecords() -> [PersonalRecord] {
        guard let data = userDefaults.data(forKey: recordsKey),
              let records = try? JSONDecoder().decode([PersonalRecord].self, from: data) else {
            return []
        }
        return records.sorted { $0.date > $1.date }
    }
    
    func saveRecord(_ record: PersonalRecord) {
        var records = getRecords()
        records.append(record)
        
        // 최신순 정렬
        records.sort { $0.date > $1.date }
        
        // 최대 3개만 유지
        if records.count > maxRecords {
            records = Array(records.prefix(maxRecords))
        }
        
        if let data = try? JSONEncoder().encode(records) {
            userDefaults.set(data, forKey: recordsKey)
        }
    }
    
    func deleteRecord(id: UUID) {
        var records = getRecords()
        records.removeAll { $0.id == id }
        
        if let data = try? JSONEncoder().encode(records) {
            userDefaults.set(data, forKey: recordsKey)
        }
    }
}
