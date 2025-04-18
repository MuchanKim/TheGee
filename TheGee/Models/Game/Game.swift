//
//  GameModels.swift
//  TheGee
//
//  Created by AI Assistant on 4/19/25.
//

import Foundation

// MARK: - 게임 모델 정의
/// 게임에서 사용되는 모든 모델 열거형을 정의합니다.

// MARK: 게임 캐릭터 타입
/// 게임에 등장하는 캐릭터 유형을 나타내는 열거형
enum Character {
    case bee
    case digda
    case none
    
    /// 캐릭터 이미지 이름 반환
    var imageName: String {
        switch self {
        case .bee:
            return "Bee"
        case .digda:
            return "BigDigda"
        case .none:
            return ""
        }
    }
}

// MARK: 게임 상태
/// 게임 진행 상태를 나타내는 열거형
enum GameState {
    case waiting      // 캐릭터 등장 대기 중
    case playing      // 캐릭터 등장, 터치 대기중
    case reaction     // 터치 후 반응 표시 중 (꿀벌 울거나 웃음)
    case finished     // 게임 종료
}

// MARK: 캐릭터 상태
/// 캐릭터의 감정 상태를 나타내는 열거형
enum CharacterState {
    case normal
    case crying
    case happy
} 