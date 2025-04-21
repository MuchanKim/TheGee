//
//  ButtonView.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//

import SwiftUI

/// 커스텀 가능한 액션 버튼 컴포넌트
///
/// 다양한 스타일링 옵션을 제공하는 재사용 가능한 버튼 컴포넌트입니다.
///
/// ```swift
/// ActionButtonView(
///     title: "START",
///     icon: "play.fill",
///     backgroundColor: Color("StartButtonColor"),
///     foregroundColor: .white,
///     borderColor: Color("StartButtonStroke"),
///     action: { print("버튼 탭됨") }
/// )
/// ```
///
/// - Parameters:
///   - title: 버튼에 표시할 텍스트
///   - icon: SF Symbols 아이콘 이름
///   - backgroundColor: 버튼 배경색
///   - foregroundColor: 아이콘과 텍스트 색상 (기본값: .white)
///   - borderColor: 테두리 색상 (nil이면 테두리 없음, 기본값: nil)
///   - borderWidth: 테두리 두께 (기본값: 5)
///   - width: 버튼 너비 (기본값: 150)
///   - height: 버튼 높이 (기본값: 70)
///   - cornerRadius: 모서리 둥글기 (기본값: 15)
///   - shadowRadius: 그림자 크기 (기본값: 5)
///   - action: 버튼 탭 시 실행할 클로저
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
                    .font(.buttonText())
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
}
