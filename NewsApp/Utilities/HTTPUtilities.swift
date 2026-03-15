//
//  HTTPUtilities.swift
//  NewsApp
//
//  Created by Akshay Kumar on 09/03/26.
//

import Foundation

enum HTTPError: Error {
    case serverError
    case decodeDataError
}

protocol HTTPUtilitiesProtocol {
    func execute<T:Decodable>(request: URLRequest) async throws -> T?
}

final class HTTPUtilities: HTTPUtilitiesProtocol {
    
    func execute<T>(request: URLRequest) async throws -> T? where T : Decodable {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let responseData = response as? HTTPURLResponse else {
                throw HTTPError.serverError
            }
            
            guard (200...299).contains(responseData.statusCode) else {
                throw HTTPError.serverError
            }
            do {
                let decodeData = JSONDecoder()
                decodeData.dateDecodingStrategy = .iso8601
                return try decodeData.decode(T.self, from: data)
            } catch {
                throw HTTPError.decodeDataError
            }
            
        }
        catch {
            print(error.localizedDescription)
            throw HTTPError.serverError
        }
    }
}
