//
//  NetworkClient.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation

struct NetworkClient {

    static let baseURL = "http://152.70.239.43:3000"

    static func request<T: Decodable>(
        endpoint: APIEndpoint,
        body: Data? = nil
    ) async throws -> T {

        var components = URLComponents(string: baseURL + endpoint.path)

        if let queryParameters = endpoint.queryParameters {
            components?.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }

        
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body

        print("🚀 Request URL: \(url)")
        print("📦 Request Body: \(String(data: body ?? Data(), encoding: .utf8) ?? "")")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("✅ Status Code: \(httpResponse.statusCode)")
            
            guard let http = response as? HTTPURLResponse,
                  (200...299).contains(http.statusCode) else {
                throw URLError(.badServerResponse)
            }
        }

        return try JSONDecoder().decode(T.self, from: data)
        
        }
    }



