//
//  NetworkClient.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation

struct NetworkClient {

    static let baseURL = "https://YOUR_SERVER_URL"

    static func request<T: Decodable>(
        endpoint: APIEndpoint,
        body: Data? = nil
    ) async throws -> T {

        let url = URL(string: baseURL + endpoint.path)!
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

