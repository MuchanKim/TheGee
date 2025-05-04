//
//  FirestoreRankingRepository.swift
//  TheGee
//
//  Created by Moo on 4/21/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

/// Firebase Firestore를 사용한 랭킹 저장소 구현
final class FirestoreRankingRepository: RankingRepository {
    // MARK: - 프로퍼티
    
    private let db: Firestore
    private let collectionName: String
    
    // MARK: - 초기화
    
    /// 기본 초기화 메서드
    /// - Parameters:
    ///   - db: Firestore 인스턴스 (기본값: Firestore.firestore())
    ///   - collectionName: 컬렉션 이름 (기본값: "rankings")
    init(
        db: Firestore = Firestore.firestore(),
        collectionName: String = "rankings"
    ) {
        self.db = db
        self.collectionName = collectionName
    }
    
    // MARK: - RankingRepository 구현
    
    /// 새로운 랭킹 데이터를 Firestore에 저장합니다.
    /// - Parameters:
    ///   - nickname: 사용자 닉네임 (문자열)
    ///   - reactionTime: 반응 시간 (밀리초 단위)
    ///   - completion: 저장 작업 완료 후 호출되는 클로저
    ///     - 성공 시: `.success(())`
    ///     - 실패 시: `.failure(Error)` - Firestore 작업 중 발생한 오류
    func saveRanking(nickname: String, reactionTime: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        // 1. 랭킹 데이터 준비
        let data: [String: Any] = [
            "nickname": nickname,
            "reactionTime": reactionTime,
            "createdAt": FieldValue.serverTimestamp()
        ]
        
        // 2. Firestore에 데이터 저장
        db.collection(collectionName).document().setData(data) { error in
            if let error = error {
                // 오류 발생 시 실패 결과 전달
                completion(.failure(error))
            } else {
                // 성공 시 성공 결과 전달
                completion(.success(()))
            }
        }
    }
    
    /// 상위 랭킹 데이터를 반응 시간 기준 오름차순으로 조회합니다.
    /// - Parameters:
    ///   - limit: 조회할 최대 랭킹 수
    ///   - completion: 조회 작업 완료 후 호출되는 클로저
    ///     - 성공 시: `.success([Rank])` - 조회된 랭킹 목록 (빈 배열 가능)
    ///     - 실패 시: `.failure(Error)` - Firestore 작업 중 발생한 오류
    func getTopRankings(limit: Int, completion: @escaping (Result<[Rank], Error>) -> Void) {
        // 1. 쿼리 구성 - 반응 시간 오름차순 정렬, 지정된 개수만 조회
        db.collection(collectionName)
            .order(by: "reactionTime", descending: false)  // 반응 시간이 낮을수록 상위 랭킹
            .limit(to: limit)
            .getDocuments { snapshot, error in
                // 2. 오류 처리
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // 3. 결과가 없는 경우 처리
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                // 4. 문서를 Rank 모델로 변환
                let ranks = documents.compactMap { document -> Rank? in
                    Rank(documentID: document.documentID, data: document.data())
                }
                
                // 5. 결과 전달
                completion(.success(ranks))
            }
    }
}
