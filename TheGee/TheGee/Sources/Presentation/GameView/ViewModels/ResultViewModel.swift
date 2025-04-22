// Presentation/Contents/ViewModels/ResultViewModel.swift

import Foundation
import Combine

/// 게임 결과 및 랭킹 등록을 관리하는 뷰모델
final class ResultViewModel: ObservableObject {
    // MARK: - 상태 변수
    
    /// 사용자 닉네임
    @Published var nickname: String = ""
    
    /// 랭킹 저장 중 여부
    @Published var isSaving: Bool = false
    
    /// 오류 메시지
    @Published var errorMessage: String? = nil
    
    /// 저장 완료 여부
    @Published var isComplete: Bool = false
    
    // MARK: - 서비스 의존성
    
    /// 랭킹 서비스
    private let rankingService: RankingService
    
    // MARK: - 초기화
    
    /// 뷰모델 초기화
    /// - Parameter rankingService: 랭킹 서비스 (기본값: 공유 인스턴스)
    init(rankingService: RankingService = RankingService.shared) {
        self.rankingService = rankingService
    }
    
    // MARK: - 메서드
    
    /// 글로벌 랭킹에 기록을 저장합니다
    /// - Parameter reactionTime: 평균 반응 시간 (밀리초 단위)
    func saveRanking(reactionTime: Int) {
        guard !nickname.isEmpty else {
            errorMessage = "닉네임을 입력해주세요"
            return
        }
        
        isSaving = true
        errorMessage = nil
        
        rankingService.saveRanking(nickname: nickname, reactionTime: reactionTime) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isSaving = false
                
                switch result {
                case .success:
                    self.isComplete = true
                case .failure(let error):
                    self.errorMessage = "랭킹 등록에 실패했습니다: \(error.localizedDescription)"
                }
            }
        }
    }
}