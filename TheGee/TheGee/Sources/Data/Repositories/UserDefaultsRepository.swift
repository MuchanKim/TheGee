import Foundation

/// UserDefaults를 이용한 저장소 구현체
class UserDefaultsRepository: PersonalRecordRepository {
    // 싱글톤 인스턴스
    static let shared = UserDefaultsRepository()
    
    private let recordsKey = "personalRecords"
    private let maxRecords = 3
    
    private init() {}
    
    func getRecords() -> [PersonalRecord] {
        guard let data = UserDefaults.standard.data(forKey: recordsKey),
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
            UserDefaults.standard.set(data, forKey: recordsKey)
        }
    }
    
    func deleteRecord(id: UUID) {
        var records = getRecords()
        records.removeAll { $0.id == id }
        
        if let data = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(data, forKey: recordsKey)
        }
    }
}