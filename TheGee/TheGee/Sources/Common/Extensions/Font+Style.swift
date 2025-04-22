//
//  Font+Style.swift
//  TheGee
//
//  Created by Moo on 4/24/25.
//

import SwiftUI

// MARK: - 폰트 확장
extension Font {
    /// 게임 타이틀용 헤더 폰트
    static func gameTitle(size: CGFloat = 40) -> Font {
        .custom("DNFBitBitOTF", size: size)
    }
    
    /// 버튼 텍스트용 폰트
    static func buttonText(size: CGFloat = 16) -> Font {
        .system(size: size, weight: .bold)
    }

    /// 카드 제목용 폰트
    static func cardTitle(size: CGFloat = 24) -> Font {
        .system(size: size, weight: .bold)
    }
    
    /// 카드 본문용 폰트
    static func cardBody(size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular)
    }
    
    /// 메시지용 폰트
    static func gameMessage(size: CGFloat = 28) -> Font {
        .system(size: size, weight: .bold)
    }
    
    /// G마켓 볼드체
    static func gmarketBold(size: CGFloat = 20) -> Font {
        .custom("GmarketSansBold", size: size)
    }
    
    /// G마켓 미디엄체
    static func gmarketMedium(size: CGFloat = 14) -> Font {
        .custom("GmarketSansMedium", size: size)
    }
} 
