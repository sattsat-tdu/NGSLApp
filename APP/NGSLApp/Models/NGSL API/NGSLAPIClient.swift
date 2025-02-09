//
//  NGSLAPIClient.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

import Foundation

final class NGSLAPIClient {
    private let baseURL = URL(string: "http://localhost:8000")!
    
    func fetchWords(request: WordsRequest) async -> Result<WordsResponse, NGSLAPIClientError> {
        /// エンドポイントを指定
        var urlComponents = URLComponents(
            url: baseURL.appending(path: "/words"),
            resolvingAgainstBaseURL: true
        )
        
        let items = [
            "pos": request.pos,
            "count": request.count,
            "start": request.start
        ] as [String: Any?]
        /// requestを適応しながらnilを除外
        let queryItems = items.compactMapValues{ $0 }
        urlComponents?.queryItems = queryItems.map{ key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        /// URLが有効かチェック
        guard let url = urlComponents?.url else {
            return .failure(.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data,response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                preconditionFailure()
            }
            
            switch httpURLResponse.statusCode {
            case 200:
                do {
                    let wordsResponse = try JSONDecoder().decode(WordsResponse.self, from: data)
                    return .success(wordsResponse)
                } catch {
                    return .failure(.parseError)
                }
            case 400:
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return .failure(.apiResponseError(.badRequest(response: errorResponse)))
                } catch {
                    return .failure(.parseError)
                }
            case 401:
                return .failure(.apiResponseError(.tokenError))
            case 422:
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return .failure(.apiResponseError(.validationError(response: errorResponse)))
                } catch {
                    return .failure(.parseError)
                }
            case 500:
                return .failure(.apiResponseError(.serverError))
            default:
                return .failure(.apiResponseError(.undefined(statusCode: httpURLResponse.statusCode)))
            }
        } catch {
            return .failure(.urlSessionError(.unknown(error)))
        }
    }
}
