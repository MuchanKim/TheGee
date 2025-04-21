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
    @StateObject private var rankViewModel = RankViewModel()
    @StateObject private var personalRecordViewModel = PersonalRecordViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            // 배경 이미지
            Image("Cave")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.95)
            
            // 메인 콘텐츠 - 스크롤 가능한 영역
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    // 상단 여백 - 뒤로가기 버튼을 위한 공간
                    Spacer()
                        .frame(height: 86)
                    
                    // 랭킹 타이틀
                    HStack {
                        Text("Ranking")
                            .font(.custom("DNFBitBitOTF", size: 32))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 2)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 26)
                    .padding(.bottom, 6)
                    
                    // 랭킹 리스트
                    RankListView(items: rankViewModel.rankingItems)
                    
                    Spacer()
                    
                    // 개인 기록 타이틀
                    HStack {
                        Text("My Records")
                            .font(.custom("DNFBitBitOTF", size: 32))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 2)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 26)
                    .padding(.bottom, 6)
                    
                    // 개인 기록 리스트 - PersonalRecordViewModel 사용
                    RecordsView(
                        records: personalRecordViewModel.sortedByRecentDate,
                        onDelete: { id in
                            personalRecordViewModel.deleteRecord(id: id)
                        },
                        formatDate: personalRecordViewModel.formatDate
                    )
                    
                    // 하단 여백
                    Spacer(minLength: 10)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .overlay(
                // 로딩 오버레이
                Group {
                    if rankViewModel.isLoading || personalRecordViewModel.isLoading {
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
            .zIndex(10) // 최상위 레이어로 설정하여 항상 터치 가능하게 함
            
            // 오류 메시지 
            if let errorMessage = rankViewModel.errorMessage {
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
        }
        .navigationBarBackButtonHidden(true)
    }
}


// MARK: - 프리뷰
#Preview {
    RankView()
}
