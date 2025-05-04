//
//  RankListView.swift
//  TheGee
//
//  Created by Moo on 4/19/25.
//

import SwiftUI

// MARK: - 랭킹 리스트 뷰
/// 랭킹 목록을 표시하는 컨테이너 뷰
struct RankListView: View {
    let items: [RankingItem]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(items) { item in
                RankItemView(item: item)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("CardColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("CardStroke"), lineWidth: 5)
                )
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
        )
        .padding(.horizontal, 20)
    }
}


// MARK: - 랭킹 아이템 뷰
/// 개별 랭킹 항목을 표시하는 뷰
struct RankItemView: View {
    let item: RankingItem
    
    var body: some View {
        HStack {
            // 순위 아이콘 (1-5위까지 다른 아이콘 표시)
            ZStack {
                Circle()
                    .fill(item.rankColor)
                    .frame(width: 30, height: 30)
                
                Text("\(item.rank)")
                    .font(.buttonText(size: 15))
                    .foregroundColor(.white)
            }
            .padding(.leading, 12)
            
            // 닉네임
            Text(item.nickname)
                .font(.cardTitle(size: 18))
                .foregroundColor(.black)
                .padding(.leading, 12)
            
            Spacer()
            
            // 기록
            Text(item.formattedReactionTime)
                .font(.cardTitle(size: 18))
                .foregroundColor(.black)
                .padding(.trailing, 12)
        }
        .frame(height: 52)
        .background(
            RoundedRectangle(cornerRadius: 26)
                .fill(Color(UIColor(red: 0.98, green: 0.9, blue: 0.7, alpha: 1.0)))
                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
    }
}
