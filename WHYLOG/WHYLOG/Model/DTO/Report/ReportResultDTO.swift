//
//  ReportResultDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation

struct ReportResultResponse: Decodable {
    let result: ReportResultDTO
}

struct ReportResultDTO: Decodable {
    let year: Int
    let standard: String
    let graphData: [GraphDataDTO]
}

struct GraphDataDTO: Decodable {
    let categoryId: Int
    let categoryName: String
    let count: Int
    let percent: Int
}

