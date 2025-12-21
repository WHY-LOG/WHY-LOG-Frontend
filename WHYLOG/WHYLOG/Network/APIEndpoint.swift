//
//  APIEndpoint.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

enum APIEndpoint {

    // MARK: - Report
    case createReport(userId: Int)
    case fetchReports(userId: Int)
    case updateReport(userId: Int, reportId: Int)
    case deleteReport(userId: Int, reportId: Int)

    // MARK: - User
    case createUser
    case fetchUser(userId: Int)
    case updateUser(userId: Int)
    case deleteUser(userId: Int)

    // MARK: - Record
    case createRecord(userId: Int)
    case fetchRecords(
        userId: Int,
        year: Int,
        month: Int,
        categoryId: Int?
    )
    case updateRecord(userId: Int, recordId: Int)
    case deleteRecord(userId: Int, recordId: Int)
}

// MARK: -
extension APIEndpoint {

    //path
    var path: String {
        switch self {
            
            // MARK: - Report
        case .fetchReports(let userId):
            return "/api/users/\(userId)/reports"
            
        case .createReport(let userId):
            return "/api/user/\(userId)/reports"
            
        case .updateReport(let userId, let reportId),
                .deleteReport(let userId, let reportId):
            return "/api/users/\(userId)/reports/\(reportId)"
            
            // MARK: - User
        case .createUser:
            return "/api/user"
            
        case .fetchUser(let userId),
                .updateUser(let userId),
                .deleteUser(let userId):
            return "/api/user/\(userId)"
            
            // MARK: - Record
        case .createRecord(let userId),
                .fetchRecords(let userId, _, _, _):
            return "/api/users/\(userId)/records"
            
            
            
        case .updateRecord(let userId, let recordId),
                .deleteRecord(let userId, let recordId):
            return "/api/users/\(userId)/records/\(recordId)"
        }
    }

    // method
    var method: HTTPMethod {
        switch self {
        case .fetchReports, .fetchUser, .fetchRecords:
            return .get
        case .createReport, .createUser, .createRecord:
            return .post
        case .updateReport, .updateUser, .updateRecord:
            return .put
        case .deleteReport, .deleteUser, .deleteRecord:
            return .delete
        }
    }
    
    // 쿼리 파라미터
    var queryParameters: [String: Any]? {
            switch self {

            case .fetchRecords(_, let year, let month, let categoryId):
                var params: [String: Any] = [
                    "year": year,
                    "month": month
                ]

                if let categoryId {
                    params["categoryId"] = categoryId
                }

                return params

            default:
                return nil
            }
        }
}

