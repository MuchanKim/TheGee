//
//  RankView.swift
//  TheGee
//
//  Created by Moo on 4/19/25.
//

import SwiftUI

// MARK: - 랭킹 화면
/// 사용자 랭킹 및 개인 기록을 표시하는 화면
struct RankView: View {
    @Environment(\.dismiss) private var dismissAction
    @StateObject private var viewModel = RankViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                Spacer()
                    .frame(height: 86)
                
                HStack {
                    Text("Ranking")
                        .font(.gameTitle(size: 32))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 2)
                    
                    Spacer()
                }
                .padding(.horizontal, 26)
                .padding(.bottom, 6)
                
                RankListView(items: viewModel.rankingItems)
                
                Spacer()
                
                HStack {
                    Text("My Records")
                        .font(.gameTitle(size: 32))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 2)
                    
                    Spacer()
                }
                .padding(.horizontal, 26)
                .padding(.bottom, 6)
                
                // 개인 기록 리스트
                RecordsView(
                    records: viewModel.sortedByRecentDate,
                    onDelete: { id in
                        viewModel.deleteRecord(id: id)
                    },
                    formatDate: viewModel.formatDate
                )
                
                // 하단 여백
                Spacer(minLength: 10)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay(
            // 로딩 오버레이
            Group {
                if viewModel.isLoading {
                    ZStack {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                        
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                    }
                }
            }
        )
        .overlay(
            // 상단 고정 영역 - 최상위 레이어로 배치
            VStack {
                HStack {
                    // 뒤로가기 버튼
                    BackButtonView(action: {
                        dismissAction()
                    })
                    .padding([.leading, .top], 16)
                    
                    Spacer()
                }
                .padding(.top, 25)
                
                Spacer()
            }
            .zIndex(10), // 최상위 레이어로 설정하여 항상 터치 가능하게 함
            alignment: .top
        )
        .overlay(
            // 오류 메시지 
            Group {
                if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Spacer()
                        
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red.opacity(0.8))
                            )
                            .padding(.bottom, 20)
                    }
                }
            },
            alignment: .bottom
        )
        .caveBackground()
        .navigationBarBackButtonHidden(true)
    }
}


// MARK: - 프리뷰
#Preview {
    RankView()
}
