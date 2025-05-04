//
//  BackButton.swift
//  TheGee
//
//  Created by Moo on 4/18/25.
//

import SwiftUI

// MARK: - 뒤로가기 버튼 뷰
/**
 재사용 가능한 뒤로가기 버튼 컴포넌트
 - 텍스트, 폰트, 배경색 등을 커스터마이징 가능
 */
struct BackButtonView: View {
    // 액션 클로저
    var action: () -> Void
    
    // 커스터마이징 속성
    var text: String = "뒤로 가기"
    var iconName: String = "chevron.left"
    var fontWeight: Font.Weight = .regular
    var fontSize: CGFloat = 16
    var foregroundColor: Color = .white
    var backgroundColor: Color = Color.black
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(backgroundColor)
                    .frame(width: 110, height: 40)
                
                HStack(spacing: 4) {
                    Image(systemName: iconName)
                    Text(text)
                }
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundColor(foregroundColor)
            }
        }
    }
}
