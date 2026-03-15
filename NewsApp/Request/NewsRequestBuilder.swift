//
//  NewsRequestBuilder.swift
//  NewsApp
//
//  Created by Akshay Kumar on 10/03/26.
//

import Foundation

protocol NewsRequestBuilderProtocol: AnyObject {
    func fetchArticleData(limit: String) -> URLRequest?
}

final class NewsRequestBuilder: NewsRequestBuilderProtocol {
//    https://api.thenewsapi.com/v1/news/top?api_token=rNpHYfjJDlR9dLxmMsEveMHrpfBnrOaxW9NODA0M&locale=us&limit=3
    private let baseURL: URL
    init(baseURL: URL = URL(string: "https://api.thenewsapi.com/v1/news/top?api_token=rNpHYfjJDlR9dLxmMsEveMHrpfBnrOaxW9NODA0M&locale=us&limit=")!) {
        self.baseURL = baseURL
    }
    
    func fetchArticleData(limit: String) -> URLRequest? {
        let endPoint = baseURL.appending(path: limit)
        let components = URLComponents(url: endPoint, resolvingAgainstBaseURL: false)
        
        guard let url = components?.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
}

