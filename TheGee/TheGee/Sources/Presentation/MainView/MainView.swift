//
//  MainView.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//

import SwiftUI

struct MainView: View {
    @State private var navigateToGame = false
    @State private var navigateToRanking = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경 이미지
                Image("Cave")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.85)
                
                // 메인 콘텐츠
                ScrollView {
                    VStack(spacing: 25) {
                        // 헤더
                        Text("TheGee's\nJourney")
                            .font(.custom("DNFBitBitOTF", size: 40))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 60)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                        
                        // 게임 설명 카드 - 새로운 컴포넌트 사용
                        ChallengeCardView(
                            title: "순발력을 테스트하라!",
                            description: "게임 방법은 간단합니다.\n벌이 덮치면 벌을 잽싸게 터치해서 잡으세요.\nThe gameplay is simple.\nWhen a bee swarms you,\nquickly touch the bee to catch it.",
                            imageName: "Bee",
                            infoItems: InfoItem.defaultItems
                        )
                        
                        Spacer(minLength: 50)
                        
                        // 버튼 영역 - 새로운 컴포넌트 사용
                        ButtonsContainerView(
                            startAction: { navigateToGame = true },
                            rankingAction: { navigateToRanking = true }
                        )
                        .padding(.bottom, 40)
                    }
                    .frame(minHeight: UIScreen.main.bounds.height - 50)
                }
            }
            .navigationDestination(isPresented: $navigateToGame) {
                GameView()
            }
            .navigationDestination(isPresented: $navigateToRanking) {
                RankingView()
            }
        }
        .navigationBarHidden(true)
    }
}

// 임시 게임 뷰
struct GameView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("게임 화면")
                .font(.largeTitle)
            
            Text("여기서 꿀벌을 터치하는 게임을 구현합니다")
                .padding()
            
            ActionButtonView.backButton {
                // 뒤로 가기 로직
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// 임시 랭킹 뷰
struct RankingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
            Text("랭킹 화면")
                .font(.largeTitle)
            
            Text("여기서 최고 점수 목록을 확인합니다")
                .padding()
            
            ActionButtonView.backButton {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
