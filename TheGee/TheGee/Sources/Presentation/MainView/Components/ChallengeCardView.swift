//
//  ChallengeCardView.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//

import SwiftUI

struct ChallengeCardView: View {
    var title: String
    var description: String
    var imageName: String
    var infoItems: [InfoItem]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("CardColor"))
                .frame(maxWidth: 350)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            VStack(spacing: 20) {
                // 캐릭터 이미지
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                // 타이틀
                Text(title)
                    .font(.custom("DNFBitBitOTF", size: 20))
                    .fontWeight(.bold)
                
                // 설명
                Text(description)
                    .font(.subheadline)
                    .lineSpacing(5)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // 게임 정보를 가로로 배치
                InfoListView(items: infoItems)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 15)
        }
        .padding(.horizontal)
    }
}

struct InfoListView: View {
    let items: [InfoItem]
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(items) { item in
                InfoRowView(
                    icon: item.icon,
                    text: item.text,
                    horizontalPadding: item.horizontalPadding,
                    iconSpacing: item.iconSpacing
                )
            }
        }
        .padding(.top, 10)
    }
}

struct InfoRowView: View {
    let icon: String
    let text: String
    var horizontalPadding: CGFloat = 30
    var iconSpacing: CGFloat = 10
    
    var body: some View {
        HStack(spacing: iconSpacing) {
            Image(systemName: icon)
                .font(.headline)
            Text(text)
                .font(.subheadline).bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, horizontalPadding)
    }
}

struct InfoItem: Identifiable {
    let id = UUID()
    let icon: String
    let text: String
    var horizontalPadding: CGFloat = 30
    var iconSpacing: CGFloat = 10
    
    static let gameTimeItem = InfoItem(
        icon: "clock.fill",
        text: "게임시간: 1분 ~ 2분"
    )
    
    static let gameTypeItem = InfoItem(
        icon: "gamecontroller.fill",
        text: "게임 형태: 미니게임",
        horizontalPadding: 25,
        iconSpacing: 6
    )
    
    static let warningItem = InfoItem(
        icon: "exclamationmark.triangle.fill",
        text: "동료 더지가 나타날 수도 있습니다."
    )
    
    static let defaultItems = [
        gameTimeItem,
        gameTypeItem,
        warningItem
    ]
}

#Preview {
    ChallengeCardView(
        title: "순발력을 테스트하라!",
        description: "게임 방법은 간단합니다.\n벌이 덮치면 벌을 잽싸게 터치해서 잡으세요.\nThe gameplay is simple.\nWhen a bee swarms you,\nquickly touch the bee to catch it.",
        imageName: "Bee",
        infoItems: InfoItem.defaultItems
    )
} 