/// 랭킹 데이터 액세스를 위한 저장소 인터페이스
protocol RankingRepository {
    /// 새로운 랭킹 데이터를 저장합니다.
    /// - Parameters:
    ///   - nickname: 사용자 닉네임
    ///   - reactionTime: 반응 시간 (밀리초 단위)
    ///   - completion: 저장 작업 완료 후 호출되는 클로저
    func saveRanking(nickname: String, reactionTime: Int, completion: @escaping (Result<Void, Error>) -> Void)
    
    /// 상위 랭킹 데이터를 조회합니다.
    /// - Parameters:
    ///   - limit: 조회할 최대 랭킹 수
    ///   - completion: 조회 작업 완료 후 호출되는 클로저
    func getTopRankings(limit: Int, completion: @escaping (Result<[Rank], Error>) -> Void)
}
