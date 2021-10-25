//
//  ApiCaller.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 25/10/21.
//

import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    
    private
    
    private init() {}
    
    //MARK: - Public
    
    //get stock info
    
    //search stocks
    
    //MARK: - Private
    
    private enum Endpoint: String {
        case search
    }
    
    private enum ApiError: Error {
        case noDataReturned
        case invalidUrl
    }
    
    private func url(
        for endpoint: Endpoint,
        queryParams: [String: String] = [:]
    ) -> URL? {
        
        return nil
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let url = url else {
            //Invalid url
            completion(.failure(ApiError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(ApiError.noDataReturned))
                }
                return
            }
            
            do {
                let  result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
