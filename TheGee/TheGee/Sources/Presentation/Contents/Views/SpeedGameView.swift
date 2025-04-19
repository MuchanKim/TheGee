//
//  SpeedGame.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//

import Foundation
import SwiftUI

// MARK: - 스피드 게임 뷰
/// 사용자가 꿀벌과 디그다를 터치하는 게임 화면
struct SpeedGameView: View {
    // MARK: 프로퍼티
    @Environment(\.dismiss) private var dismissAction
    @StateObject private var viewModel = SpeedGameViewModel()
    @StateObject private var rankViewModel = RankViewModel()
    
    // MARK: 바디
    var body: some View {
        ZStack {
            // 동굴 배경
            Image("Cave")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.95)
            
            // 상단 뒤로가기 버튼
            VStack {
                HStack {
                    BackButtonView(action: {
                        dismissAction()
                    })
                    .padding([.leading, .top], 16)
                    
                    Spacer()
                }
                .padding(.top, 25)  // 버튼 전체 영역을 아래로 내림
                
                Spacer()
            }
            
            // 캐릭터와 메시지를 함께 배치 (캐릭터 바로 위에 메시지)
            if viewModel.currentCharacter != .none {
                VStack(spacing: 15) {
                    if !viewModel.reactionMessage.isEmpty {
                        GameMessageView(
                            message: viewModel.reactionMessage,
                            character: viewModel.currentCharacter,
                            showsReactionTime: viewModel.reactionMessage.contains("ms")
                        )
                    }
                    
                    CharacterImageView(character: viewModel.currentCharacter, state: viewModel.characterState)
                        .frame(width: 200, height: 200)
                        .contentShape(Rectangle())
                }
            }
            
            // 결과 화면 오버레이
            if viewModel.showResults {
                ResultView(
                    reactionTimes: viewModel.reactionTimes,
                    averageTime: viewModel.calculateAverageReactionTime(),
                    onClose: {
                        dismissAction()
                    },
                    onRestart: {
                        viewModel.startGame()
                    },
                    onSaveRecord: {
                        rankViewModel.saveRecord(reactionTime: viewModel.calculateAverageReactionTime())
                    }
                )
                .transition(.opacity)
                .animation(.easeInOut, value: viewModel.showResults)
                .zIndex(1) // 결과 화면을 최상위 레이어로 설정
            }
        }
        .onTapGesture {
            viewModel.didTapScreen()
        }
        .onAppear {
            viewModel.startGame()
        }
        .onReceive(viewModel.$isGameFinished) { isFinished in
            if isFinished {
                dismissAction()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - 게임 메시지 뷰
/**
 게임 내에서 메시지를 표시하는 재사용 가능한 컴포넌트
 - 캐릭터 타입에 따라 배경색 자동 조정
 - 반응시간 표시 여부에 따라 배경색 변경
 */
struct GameMessageView: View {
    // 메시지 내용
    let message: String
    
    // 메시지 컨텍스트
    var character: Character = .none
    var showsReactionTime: Bool = false
    
    // 스타일 커스터마이징
    var fontSize: CGFloat = 28
    var fontWeight: Font.Weight = .bold
    var textColor: Color = .white
    var cornerRadius: CGFloat = 12
    
    // 크기 속성 (기본값)
    var minWidth: CGFloat = 120
    var minHeight: CGFloat = 44
    
    var body: some View {
        ZStack {
            // 배경
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .frame(width: 260, height: 80)
            
            // 텍스트
            Text(message)
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundColor(textColor)
                .lineLimit(1)
        }
        .frame(minWidth: minWidth, minHeight: minHeight)
    }
    
    /// 상황에 따라 배경색을 결정합니다.
    private var backgroundColor: Color {
        switch character {
        case .bee:
            return Color.red
        case .digda:
            return Color.black
        case .none:
            if showsReactionTime {
                return Color.green
            } else {
                return Color.red
            }
        }
    }
}

// MARK: - 캐릭터 이미지 뷰
/**
 게임에 등장하는 캐릭터 이미지를 표시하는 뷰
 - 현재 캐릭터 타입과 상태에 따라 적절한 이미지를 표시
 - Character enum의 getImageName 메서드를 활용하여 이미지 결정
 */
struct CharacterImageView: View {
    let character: Character
    let state: CharacterState
    
    var body: some View {
        if character == .none {
            EmptyView()
        } else {
            Image(character.getImageName(for: state))
                .resizable()
                .scaledToFit()
        }
    }
}

// MARK: - 프리뷰 헬퍼

// MARK: 네비게이션 래퍼
/// 프리뷰를 위한 네비게이션 래퍼 뷰
struct SpeedGameNavigationView: View {
    var body: some View {
        NavigationStack {
            SpeedGameView()
        }
    }
}

#Preview {
    SpeedGameNavigationView()
} 
