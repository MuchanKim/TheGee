//
//  SpeedGameViewModel.swift
//  TheGee
//
//  Created by Moo on 4/18/25.
//

import Foundation

// MARK: - SpeedGameViewModel
/**
 반응속도 게임 관련 기능을 담당하는 뷰모델
 - 게임 시작 및 초기화
 - 캐릭터 등장 및 터치 처리
 - 반응 시간 측정 및 결과 표시
 */
class SpeedGameViewModel: ObservableObject {
    // MARK: Published 상태 변수
    @Published var currentCharacter: Character = .none
    @Published var gameState: GameState = .waiting
    @Published var reactionTime: Int = 0
    @Published var reactionMessage: String = ""
    @Published var currentCycle: Int = 0
    @Published var isGameFinished: Bool = false
    @Published var characterState: CharacterState = .normal
    @Published var showResults: Bool = false  // 결과 화면 표시 여부
    
    // 사이클별 반응 시간 저장
    @Published var reactionTimes: [Int] = []
    
    // MARK: - 내부 변수
    private var startTime: Date?
    private var timer: Timer?
    private var digdaCycle: Int = 0
    private let totalCycles: Int = 3
    
    // MARK: - 초기화
    /**
     뷰모델 초기화 및 디그다 등장 사이클 랜덤 설정
     - 디그다가 등장할 사이클 번호를 1~3 사이에서 랜덤하게 설정
     */
    init() {
        digdaCycle = Int.random(in: 0..<totalCycles)
    }
    
    // MARK: - 게임 로직 메서드
    
    /**
     게임을 초기화하고 시작합니다.
     - 게임 상태 초기화
     - 캐릭터 초기화
     - 반응 시간 데이터 초기화
     - 다음 캐릭터 등장 예약
     */
    func startGame() {
        gameState = .waiting
        currentCharacter = .none
        characterState = .normal
        currentCycle = 0
        reactionTimes = []
        showResults = false
        isGameFinished = false
        scheduleNextCharacter()
    }
    
    /**
     다음 캐릭터가 등장하도록 예약합니다.
     - 모든 사이클이 완료되면 게임을 종료
     - 화면 초기화 후 4-6초 랜덤 딜레이로 캐릭터 등장
     */
    private func scheduleNextCharacter() {
        // 모든 사이클 완료 시 게임 종료
        if currentCycle >= totalCycles {
            gameState = .finished
            showResults = true  // 결과 화면 표시
            return
        }
        
        resetScreenState()
        
        // 4-6초 랜덤 딜레이 후 캐릭터 등장
        let delay = Double.random(in: 3.0...5.0)
        
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            self?.showCharacter()
        }
    }
    
    /**
     현재 사이클에 맞는 캐릭터를 화면에 표시합니다.
     - 디그다 또는 벌을 표시하고 반응 시간 측정 시작
     - 디그다가 등장한 경우 2초 후 자동으로 사라짐
     */
    private func showCharacter() {
        // 현재 사이클이 디그다 사이클인지 확인
        if currentCycle == digdaCycle {
            currentCharacter = .digda
            reactionMessage = "디그다가 나타났다!"
        } else {
            currentCharacter = .bee
            reactionMessage = "벌이 나타났다!!"
        }
        
        gameState = .playing
        startTime = Date() // 반응 시간 측정 시작
        
        // 디그다 등장 시 2초 후 자동으로 사라지는 타이머 설정
        if currentCharacter == .digda {
            timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
                guard let self = self, self.currentCharacter == .digda && self.gameState == .playing else { return }
                self.characterState = .normal
                self.currentCharacter = .none
                self.gameState = .waiting
                self.currentCycle += 1
                self.scheduleNextCharacter()
            }
        }
    }
    
    /**
     사용자가 화면을 터치했을 때 호출되는 메서드
     - 벌 터치: 반응 시간 측정 및 결과 표시 후 다음 사이클로 진행
     - 디그다 터치: 게임 종료 처리 및 메인 화면으로 돌아가기
     */
    func didTapScreen() {
        guard gameState == .playing else { return }
        
        switch currentCharacter {
        case .bee:
            // 꿀벌 터치 - 반응 시간 측정
            if let startTime = startTime {
                let elapsedTime = Date().timeIntervalSince(startTime) * 1000 // 밀리초 단위
                reactionTime = Int(elapsedTime)
                reactionTimes.append(reactionTime)
                reactionMessage = "\(reactionTime).ms"
                characterState = .crying
                
                // 2초 후 다음 사이클
                gameState = .reaction
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
                    guard let self = self else { return }
                    self.currentCycle += 1
                    self.scheduleNextCharacter()
                }
            }
            
        case .digda:
            // 디그다 터치 - 게임 종료 처리
            characterState = .happy
            reactionMessage = "그거 나 아닌디 ㅋ"
            gameState = .reaction
            
            // 2초 후 메인 화면으로 돌아가기
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                self.isGameFinished = true
            }
            
        case .none:
            break
        }
    }
    
    /**
     화면을 초기화하여 다음 캐릭터가 등장할 준비를 합니다.
     - 캐릭터, 메시지, 상태 초기화
     */
    private func resetScreenState() {
        currentCharacter = .none
        reactionMessage = ""
        characterState = .normal
    }
    
    /**
     모든 사이클에서의 평균 반응 시간을 계산합니다.
     - Returns: 평균 반응 시간 (밀리초)
     */
    func calculateAverageReactionTime() -> Int {
        guard !reactionTimes.isEmpty else { return 0 }
        let sum = reactionTimes.reduce(0, +)
        return sum / reactionTimes.count
    }
    
    // MARK: - 리소스 정리
    /**
     뷰모델 해제 시 타이머 정리
     - 메모리 누수 방지를 위해 타이머 무효화
     */
    deinit {
        timer?.invalidate()
    }
}
