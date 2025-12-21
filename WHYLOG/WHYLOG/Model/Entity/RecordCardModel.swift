//
//  RememberCardModel.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation

struct RecordCardModel: Identifiable {
    let id: UUID = UUID()
    let year: Int
    let month: String
    let title: String
    let content: String
    let emotion: [String]
}

let mockLogs: [RecordDTO] = [
    RecordDTO(
        recordId: 1,
        title: "싸웠던 친구에게 다가가 화해를 하지 못 했다.",
        content: "사실 별거 아닌 거 그냥 먼저 얘기 꺼냈으면 되는건데, 자존심 때문에 소중한 인연을 놓칠 뻔 했던 것 같다. 다음에는 그러지 말아야 겠다.",
        occurDate: "3",
        categories: ["두려움", "회피"]
    )
]
