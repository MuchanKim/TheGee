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
    let onSaveRecord: (() -> Void)? // 개인 기록 저장용
    
    // ResultViewModel 사용
    @StateObject private var viewModel = ResultViewModel()
    
    // 개인 기록 저장 여부 추적
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
                    nickname: $viewModel.nickname,
                    averageTime: averageTime,
                    isSaving: viewModel.isSaving,
                    errorMessage: viewModel.errorMessage,
                    onRegistration: {
                        viewModel.saveRanking(reactionTime: averageTime)
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
        .onChange(of: viewModel.isComplete) {
            _, isComplete in
            if isComplete {
                onClose() // 저장 완료시 화면 닫기
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
