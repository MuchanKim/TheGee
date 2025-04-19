//
//  RecordView.swift
//  TheGee
//
//  Created by Moo on 4/19/25.
//

import SwiftUI

// MARK: - 개인 기록 뷰
/// 개인 기록 목록을 표시하는 컨테이너 뷰
struct PersonalRecordsView: View {
    let records: [PersonalRecord]
    let onDelete: (UUID) -> Void
    let viewModel: RankViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(records) { record in
                PersonalRecordItemView(
                    record: record,
                    viewModel: viewModel,
                    onDelete: {
                        onDelete(record.id)
                    }
                )
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

// MARK: - 개인 기록 아이템 뷰
/// 개별 개인 기록 항목을 표시하는 뷰
struct PersonalRecordItemView: View {
    let record: PersonalRecord
    let viewModel: RankViewModel
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            // 기록
            Text(record.formattedReactionTime)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, 20)
            
            Spacer()
            
            // 날짜
            Text(viewModel.formattedDateString(from: record.date))
                .font(.system(size: 16))
                .foregroundColor(.black.opacity(0.7))
                .padding(.trailing, 10)
            
            // 삭제 버튼
            Button(action: onDelete) {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red.opacity(0.8))
                    .padding(7)
            }
            .padding(.trailing, 8)
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
