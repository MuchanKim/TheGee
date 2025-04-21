//
//  MainView.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//

import SwiftUI

struct MainView: View {
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
                        TitleView()
                        
                        ChallengeCard(
                            title: "순발력을 테스트하라!",
                            description: "게임 방법은 간단합니다.\n벌이 덮치면 벌을 잽싸게 터치해서 잡으세요.\nThe gameplay is simple.\nWhen a bee swarms you,\nquickly touch the bee to catch it.",
                            imageName: "Bee",
                            infoItems: InfoItem.defaultItems
                        )
                        
                        Spacer(minLength: 5)
                        
                        HStack(spacing: 25) {
                            // 시작 버튼
                            NavigationLink(destination: SpeedGameView()) {
                                CustomActionButton(
                                    title: "START",
                                    icon: "play.fill",
                                    backgroundColor: Color("StartButtonColor"),
                                    foregroundColor: .white,
                                    borderColor: Color("StartButtonStroke"),
                                    action: {}
                                )
                            }
                            
                            // 랭킹 버튼
                            NavigationLink(destination: RankView()) {
                                CustomActionButton(
                                    title: "RANKING",
                                    icon: "trophy.fill",
                                    backgroundColor: Color("RankingButtonColor"),
                                    foregroundColor: .black,
                                    borderColor: Color("RankingButtonStroke"),
                                    action: {}
                                )
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    .frame(minHeight: UIScreen.main.bounds.height - 50)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - 헤더 타이틀 뷰
struct TitleView: View {
    var body: some View {
        Text("TheGee's\nJourney")
            .font(.gameTitle())
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.top, 60)
            .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
    }
}

#Preview {
    MainView()
}
