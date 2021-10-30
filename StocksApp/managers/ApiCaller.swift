//
//  ApiCaller.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 25/10/21.
//

import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    
    private struct Constants {
        static let apiKey = "c5s17qaad3ia8bfb6ao0"
        static let sandboxApiKey = "sandbox_c5s17qaad3ia8bfb6aog"
        static let baseUrl = "https://finnhub.io/api/v1/"
        static let secret = "c5s17qaad3ia8bfb6ap0"
    }
    
    private init() {}
    
    //MARK: - Public
    
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
            ) {
        
        //Smarter way
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        request(
            url: url(for: .search, queryParams: ["q": safeQuery]),
            expecting: SearchResponse.self,
            completion: completion)
        
//                guard let url = url(
//                    for: .search,
//                    queryParams: ["q": query]
//                ) else {
//                    return
//                }
//        print(url.absoluteURL)
            }
    
    //get stock info
    
    //search stocks
    
    public func news(
        for type: TopStoriesNewsViewController.`Type`,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        let url = url(for: .topStories, queryParams: ["category": "general"])
    }
    
    //MARK: - Private
    
    private enum Endpoint: String {
        case search
        case topStories = "news"
    }
    
    private enum ApiError: Error {
        case noDataReturned
        case invalidUrl
    }
    
    private func url(
        for endpoint: Endpoint,
        queryParams: [String: String] = [:]
    ) -> URL? {
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        
        //Add any parameters
        for (key, value) in queryParams {
            queryItems.append(.init(name: key, value: value))
        }
        
        //Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        //Convert query items to suffix string
        let queryString = queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        urlString += "?" + queryString
        
        print("\n\(urlString)\n")
        
        return URL(string: urlString)
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
