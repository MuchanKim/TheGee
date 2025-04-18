//
//  ResultView.swift
//  TheGee
//
//  Created by Moo on 4/17/25.
//

import SwiftUI

/// 게임 완료 후 결과를 표시하는 화면
struct ResultView: View {
    let reactionTimes: [Int]
    let averageTime: Int
    let onClose: () -> Void
    let onRestart: () -> Void
    
    // 닉네임 입력을 위한 상태 변수
    @State private var nickname: String = ""
    
    var body: some View {
        ZStack {
            // 동굴 배경 이미지
            Image("Cave")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 5) {
                
                // 디그다 이미지
//                Image("SmallDigda")
//                    .resizable()
//                    .frame(width: 100, height: 130)
                
                // 결과 카드
                ResultCardView(
                    nickname: $nickname,
                    averageTime: averageTime,
                    onRegistration: onRestart,
                    onSkip: onClose
                )/*.padding(.bottom, 120)*/
            }
        }
    }
}

#Preview {
    ResultView(
        reactionTimes: [320, 280, 350, 300, 290],
        averageTime: 53,
        onClose: {},
        onRestart: {}
    )
}

#Preview {
    MainView()
}
