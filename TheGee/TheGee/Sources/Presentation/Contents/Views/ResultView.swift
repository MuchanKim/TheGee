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
    let onSaveRecord: (() -> Void)? // 저장 콜백 (개인 기록 저장용)
    
    // 닉네임 입력을 위한 상태 변수
    @State private var nickname: String = ""
    // 기록 저장 여부를 추적하는 변수 추가
    @State private var isPersonalRecordSaved: Bool = false
    
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
                    onRegistration: {
                        // 여기는 나중에 파이어베이스 랭킹 등록 기능 추가 예정
                        // 등록하기 버튼을 누르면 메인 화면으로 돌아감
                        onClose()
                    },
                    onSkip: onClose
                )/*.padding(.bottom, 120)*/
            }
        }
        .onAppear {
            // 화면이 나타날 때 자동으로 개인 기록만 저장
            if !isPersonalRecordSaved {
                onSaveRecord?()
                isPersonalRecordSaved = true
            }
        }
    }
}

#Preview {
    ResultView(
        reactionTimes: [320, 280, 350, 300, 290],
        averageTime: 53,
        onClose: {},
        onRestart: {},
        onSaveRecord: {}
    )
}

#Preview {
    MainView()
}
