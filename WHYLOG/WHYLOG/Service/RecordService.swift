//
//  RecordService.swift
//  WHYLOG
//
//  Created by 김진서 on 12/21/25.
//

import Foundation

class RecordService {
    static let shared = RecordService()
    private init() {}
    
    // MARK: - 1. 한줄 기록 생성
    func createRecord(userId: Int, title: String, content: String, occurDate: String, categoryIds: [Int]) async throws -> RecordDTO {
        let requestDTO = CreateRecordRequest(
            title: title,
            content: content,
            category: categoryIds, // 매핑된 키값 사용
            occurDate: occurDate
        )
        
        let bodyData = try JSONEncoder().encode(requestDTO)
        let endpoint = APIEndpoint.createRecord(userId: userId)
        let response: CreateRecordResponse = try await NetworkClient.request(endpoint: endpoint, body: bodyData)
        return response.success
    }
    
    // MARK: - 2. 한줄 기록 조회
    func fetchRecords(userId: Int, year: Int, month: Int, categoryId: Int? = nil) async throws -> [RecordDTO] {
        let endpoint = APIEndpoint.fetchRecords(userId: userId, year: year, month: month, categoryId: categoryId)
        let response: FetchRecordsResponse = try await NetworkClient.request(endpoint: endpoint, body: nil)
        return response.success
    }
    
    // MARK: - 3. 한줄 기록 수정
    func updateRecord(userId: Int, recordId: Int, title: String, content: String, occurDate: String, categoryIds: [Int]) async throws -> RecordDTO {
        let requestDTO = UpdateRecordRequest(
            title: title,
            content: content,
            category: categoryIds,
            occurDate: occurDate
        )
        
        let bodyData = try JSONEncoder().encode(requestDTO)
        let endpoint = APIEndpoint.updateRecord(userId: userId, recordId: recordId)
        let response: UpdateRecordResponse = try await NetworkClient.request(endpoint: endpoint, body: bodyData)
        return response.success
    }
    
    // MARK: - 4. 한줄 기록 삭제
    func deleteRecord(userId: Int, recordId: Int) async throws -> Int {
        let endpoint = APIEndpoint.deleteRecord(userId: userId, recordId: recordId)
        let response: DeleteRecordResponse = try await NetworkClient.request(endpoint: endpoint, body: nil)
        return response.success
    }
}
