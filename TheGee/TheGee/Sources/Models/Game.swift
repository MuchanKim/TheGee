//
//  GameCharacter.swift
//  TheGee
//
//  Created by Moo on 4/18/25.
//

import Foundation

// MARK: 게임 캐릭터 타입
/// 게임에 등장하는 캐릭터 유형을 나타내는 enum
enum Character {
    case bee
    case digda
    case none
    
    /// 캐릭터와 상태에 따른 이미지 이름을 반환
    /// - Parameter state: 캐릭터의 상태 (기본값은 normal)
    /// - Returns: 해당 상태의 이미지 이름
    func getImageName(for state: CharacterState = .normal) -> String {
        switch self {
        case .bee:
            switch state {
            case .normal:
                return "Bee"
            case .crying:
                return "CryingBee"
            case .happy:
                return "SmileBee"
            }
        case .digda:
            return "BigDigda" // 디그다는 상태 변화 이미지 없음
        case .none:
            return ""
        }
    }
}

// MARK: 게임 상태
/// 게임 진행 상태를 나타내는 enum
enum GameState {
    case waiting      // 캐릭터 등장 대기 중
    case playing      // 캐릭터 등장, 터치 대기중
    case reaction     // 터치 후 반응 표시 중 (꿀벌 울거나 웃음)
    case finished     // 게임 종료
}

// MARK: 캐릭터 상태
/// 캐릭터의 감정 상태를 나타내는 enum
enum CharacterState {
    case normal
    case crying
    case happy
}
