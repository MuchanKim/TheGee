//
//  ResultCard.swift
//  TheGee
//
//  Created by Moo on 4/18/25.
//

import SwiftUI

/// 게임 결과를 보여주는 카드 뷰
struct ResultCardView: View {
    @Binding var nickname: String
    let averageTime: Int
    var isSaving: Bool = false
    var errorMessage: String? = nil
    let onRegistration: () -> Void
    let onSkip: () -> Void
    
    // 크기 속성
    var cardWidth: CGFloat = 320
    var cardHeight: CGFloat = 380
    
    var body: some View {
        ZStack {
            // 카드 배경 및 스트로크
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("CardColor"))
                .frame(width: cardWidth, height: cardHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("CardStroke"), lineWidth: 5)
                )
                .shadow(radius: 10)
            
            // 카드 내용
            VStack(spacing: 16) {
                // 반응 시간 타이틀과 값
                HStack {
                    Spacer()
                    
                    Text("내 기록")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text("\(averageTime) ms")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                .frame(height: 50)
                
                // 닉네임 입력 안내
                Text("닉네임 입력하면 순위 등록해줄게")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.8))
                    .frame(height: 30)
                
                // 닉네임 입력 필드
                TextField("한글 8글자 이내, 영어 12글자 이내", text: $nickname)
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.horizontal, 16)
                    .frame(width: cardWidth - 40, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                
                // 등록하기 버튼
                Button(action: onRegistration) {
                    if isSaving {
                        // 로딩 중 상태 표시
                        HStack {
                            Text("등록 중...")
                            ProgressView()
                                .scaleEffect(0.7)
                        }
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: cardWidth - 40, height: 55)
                        .background(Color("StartButtonColor").opacity(0.7))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("StartButtonStroke"), lineWidth: 3)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                    } else {
                        // 일반 상태 버튼
                        Text("등록하기")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: cardWidth - 40, height: 55)
                            .background(Color("StartButtonColor"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("StartButtonStroke"), lineWidth: 3)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                }
                .disabled(isSaving) // 저장 중에는 버튼 비활성화
                
                // 오류 메시지 표시
                if let error = errorMessage {
                    Text(error)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }
                
                // 다음에 등록 텍스트
                Button(action: onSkip) {
                    Text("다음에 등록할래요")
                        .font(.system(size: 16)).bold()
                        .foregroundColor(.gray)
                        .frame(height: 40)
                }
                .disabled(isSaving) // 저장 중에는 버튼 비활성화
            }
            .frame(width: cardWidth - 20)
        }
    }
}

#Preview {
    ResultView(
        reactionTimes: [320, 280, 350, 300, 290],
        averageTime: 53,
        onClose: {},
        onRestart: {},
        onSaveRecord: {}
    )
}
