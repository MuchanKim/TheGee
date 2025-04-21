//
//  ChallengeCardView.swift
//  TheGee
//
//  Created by Moo on 4/14/25.
//


import SwiftUI

// MARK: - 카드 뷰

/// 게임 챌린지 정보를 표시하는 카드 컴포넌트
///
/// 게임 타이틀, 설명, 이미지 및 상세 정보를 표시하는 재사용 가능한 카드 컴포넌트입니다.
/// 배경색과 테두리를 커스터마이징할 수 있습니다.
///
/// ```swift
/// ChallengeCard(
///     title: "순발력을 테스트하라!",
///     description: "게임 방법은 간단합니다.\n벌이 덮치면 벌을 잽싸게 터치해서 잡으세요.",
///     imageName: "Bee",
///     infoItems: InfoItem.defaultItems,
///     backgroundColor: Color("CustomCardColor"),
///     strokeColor: Color("CustomStrokeColor")
/// )
/// ```
///
/// - Parameters:
///   - title: 카드에 표시할 제목
///   - description: 게임에 대한 설명
///   - imageName: 카드에 표시할 이미지 이름 (앱 번들 내 이미지)
///   - infoItems: 추가 정보 항목 배열
///   - backgroundColor: 카드 배경색 (기본값: Color("CardColor"))
///   - strokeColor: 카드 테두리 색상 (기본값: Color("CardStroke"))
///   - strokeWidth: 테두리 두께 (기본값: 5)
struct ChallengeCard: View {
    let title: String
    let description: String
    let imageName: String
    let infoItems: [InfoItem]
    
    var backgroundColor: Color = Color("CardColor") 
    var strokeColor: Color = Color("CardStroke")
    var strokeWidth: CGFloat = 5
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .frame(maxWidth: 350, maxHeight: 500)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(strokeColor, lineWidth: strokeWidth)
                )
            
            VStack(spacing: 20) {
                // 캐릭터 이미지
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                // 타이틀
                Text(title)
                    .font(.gmarketBold(size: 20))
                
                // 설명
                Text(description)
                    .font(.gmarketMedium(size: 14))
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


// MARK: 소개 글
/// 정보 항목 목록을 수직으로 표시하는 뷰
///
/// - Parameters:
///   - items: 표시할 InfoItem 배열
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

/**
게임 정보 항목을 행으로 표시하는 뷰

- Parameters:
  - icon: 표시할 SF Symbols 아이콘 이름
  - text: 표시할 텍스트
  - horizontalPadding: 좌우 여백 (기본값: 30)
  - iconSpacing: 아이콘과 텍스트 사이 간격 (기본값: 10)
*/
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
                .font(.cardBody().bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, horizontalPadding)
    }
}

/// 챌린지 카드에 표시되는 정보 항목 모델
///
/// 아이콘, 텍스트 및 레이아웃 관련 속성을 포함하는 식별 가능한 정보 항목입니다.
/// 게임 시간, 게임 형태 등의 정보를 표시하는 데 사용됩니다.
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
    ChallengeCard(
        title: "순발력을 테스트하라!",
        description: "게임 방법은 간단합니다.\n벌이 덮치면 벌을 잽싸게 터치해서 잡으세요.",
        imageName: "Bee",
        infoItems: InfoItem.defaultItems,
        strokeColor: Color("CardStroke"),
        strokeWidth: 3
        )
}
