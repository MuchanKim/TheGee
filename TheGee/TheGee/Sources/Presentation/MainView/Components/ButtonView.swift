//
//  ButtonView.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//

import SwiftUI

struct ActionButtonView: View {
    let title: String
    let icon: String
    let backgroundColor: Color
    var foregroundColor: Color = .white
    var borderColor: Color? = nil
    var borderWidth: CGFloat = 5
    var width: CGFloat = 150
    var height: CGFloat = 70
    var cornerRadius: CGFloat = 15
    var shadowRadius: CGFloat = 5
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.bold)
            }
            .padding()
            .frame(width: width, height: height)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                borderColor != nil ?
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor!, lineWidth: borderWidth) : nil
            )
            .shadow(color: .black.opacity(0.2), radius: shadowRadius, x: 0, y: 3)
        }
    }
    
    // 버튼 스타일 변형을 위한 수정자
    func with(
        foregroundColor: Color? = nil,
        backgroundColor: Color? = nil,
        borderColor: Color? = nil,
        borderWidth: CGFloat? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) -> ActionButtonView {
        ActionButtonView(
            title: self.title,
            icon: self.icon,
            backgroundColor: backgroundColor ?? self.backgroundColor,
            foregroundColor: foregroundColor ?? self.foregroundColor,
            borderColor: borderColor ?? self.borderColor,
            borderWidth: borderWidth ?? self.borderWidth,
            width: width ?? self.width,
            height: height ?? self.height,
            cornerRadius: self.cornerRadius,
            shadowRadius: self.shadowRadius,
            action: self.action
        )
    }
}

struct ButtonsContainerView: View {
    let startAction: () -> Void
    let rankingAction: () -> Void
    var spacing: CGFloat = 25
    
    var body: some View {
        HStack(spacing: spacing) {
            // 시작 버튼
            startButton
            
            // 랭킹 버튼
            rankingButton
        }
    }
    
    // 시작 버튼
    private var startButton: some View {
        ActionButtonView(
            title: "START",
            icon: "play.fill",
            backgroundColor: Color("StartButtonColor"),
            foregroundColor: .white,
            borderColor: Color("StartButtonStroke"),
            action: startAction
        )
    }
    
    // 랭킹 버튼
    private var rankingButton: some View {
        ActionButtonView(
            title: "RANKING",
            icon: "trophy.fill",
            backgroundColor: Color("RankingButtonColor"),
            foregroundColor: .black,
            borderColor: Color("RankingButtonStroke"),
            action: rankingAction
        )
    }
}

// 버튼 프리셋 정의 - 빠른 재사용을 위한 팩토리 메소드
extension ActionButtonView {
    static func startButton(action: @escaping () -> Void) -> ActionButtonView {
        ActionButtonView(
            title: "START",
            icon: "play.fill",
            backgroundColor: Color("StartButtonColor"),
            foregroundColor: .white,
            action: action
        )
    }
    
    static func rankingButton(action: @escaping () -> Void) -> ActionButtonView {
        ActionButtonView(
            title: "RANKING",
            icon: "trophy.fill",
            backgroundColor: Color("RankingButtonColor"),
            foregroundColor: .orange,
            borderColor: Color("RankingButtonStroke"),
            action: action
        )
    }
    
    // 추가적인 프리셋 버튼들도 여기에 정의할 수 있습니다
    static func backButton(action: @escaping () -> Void) -> ActionButtonView {
        ActionButtonView(
            title: "BACK",
            icon: "arrow.left",
            backgroundColor: .white,
            foregroundColor: .gray,
            borderColor: .gray,
            borderWidth: 2,
            width: 120,
            height: 50,
            action: action
        )
    }
}

#Preview {
    VStack(spacing: 30) {
        ButtonsContainerView(
            startAction: {},
            rankingAction: {}
        )
        
        ActionButtonView.startButton(action: {})
        ActionButtonView.rankingButton(action: {})
        ActionButtonView.backButton(action: {})
    }
    .padding()
    .background(Color.gray.opacity(0.2))
} 
