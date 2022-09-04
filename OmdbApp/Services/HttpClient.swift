//
//  HttpClient.swift
//  OmdbApp
//
//  Created by Dirisu on 31/08/2022.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
    case unknownError
}

class HttpClient {
    func getMoviesBy(search: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: "\(Constants.baseUrl)&s=\(search)") else {
                DispatchQueue.main.async {
                    completion(.failure(.badUrl))
                }
                return;
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(.noData))
                    }
                    return;
                }
                
                guard let moviesResponse = try? JSONDecoder().decode(MovieResponse.self, from: data) else {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                    return;
                }
                
                DispatchQueue.main.async {
                    completion(.success(moviesResponse.movies))
                }
            }.resume()
        }
    }
    
    func getMoviesBy(search: String) async throws -> [Movie] {
        try await withCheckedThrowingContinuation { continuation in
            getMoviesBy(search: search) { result in
                switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .success(let movies):
                        continuation.resume(returning: movies)
                }
            }
        }
    }
}

