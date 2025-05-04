import Foundation

/// 글로벌 랭킹 관련 기능을 제공하는 서비스 클래스
final class RankingService {
    // MARK: - 프로퍼티
    
    /// Firebase 랭킹 저장소
    private let repository: RankingRepository
    
    // MARK: - 초기화
    
    init(repository: RankingRepository = FirestoreRankingRepository()) {
        self.repository = repository
    }
    
    // MARK: - 메서드
    
    /// 글로벌 랭킹에 새로운 기록을 저장합니다
    /// - Parameters:
    ///   - nickname: 사용자 닉네임
    ///   - reactionTime: 반응 시간 (밀리초 단위)
    ///   - completion: 저장 작업 완료 후 호출되는 클로저
    func saveRanking(nickname: String, reactionTime: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.saveRanking(nickname: nickname, reactionTime: reactionTime, completion: completion)
    }
    
    /// 상위 글로벌 랭킹을 조회합니다
    /// - Parameters:
    ///   - limit: 조회할 최대 랭킹 수 (기본값: 5)
    ///   - completion: 조회 작업 완료 후 호출되는 클로저
    func getRankings(limit: Int = 5, completion: @escaping (Result<[Rank], Error>) -> Void) {
        repository.getTopRankings(limit: limit, completion: completion)
    }
    
    /// 상위 글로벌 랭킹을 RankingItem 형태로 변환하여 조회합니다
    /// - Parameters:
    ///   - limit: 조회할 최대 랭킹 수 (기본값: 5)
    ///   - completion: 조회 작업 완료 후 호출되는 클로저
    func getRankingItems(limit: Int = 5, completion: @escaping (Result<[RankingItem], Error>) -> Void) {
        getRankings(limit: limit) { result in
            switch result {
            case .success(let ranks):
                // 순위를 부여하고 RankingItem으로 변환
                let rankingItems = ranks.enumerated().map { index, rank in
                    rank.toRankingItem(rank: index + 1)
                }
                completion(.success(rankingItems))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 목업 랭킹 데이터를 가져옵니다
    func getMockRankingItems() -> [RankingItem] {
        return RankingMockData.mockRankingItems()
    }
}
