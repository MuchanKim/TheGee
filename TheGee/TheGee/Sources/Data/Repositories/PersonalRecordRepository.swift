import Foundation

/// 개인 기록 저장소 인터페이스
protocol PersonalRecordRepository {
    func getRecords() -> [PersonalRecord]
    func saveRecord(_ record: PersonalRecord)
    func deleteRecord(id: UUID)
}
