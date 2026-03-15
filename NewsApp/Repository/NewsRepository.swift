//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Akshay Kumar on 10/03/26.
//

import Foundation

protocol NewsRepositoryProtocol: AnyObject {
    func getNewsArticle(limit: String) async throws -> Article?
}


class NewsRepository: NewsRepositoryProtocol {

    private let httpUtility: HTTPUtilitiesProtocol
    private let newRequestBuilder: NewsRequestBuilder
    
    init(httpUtility: HTTPUtilitiesProtocol, newRequestBuilder: NewsRequestBuilder) {
        self.httpUtility = httpUtility
        self.newRequestBuilder = newRequestBuilder
    }
    
    static var defaultRepository: NewsRepositoryProtocol {
        let httpUtility: HTTPUtilitiesProtocol = HTTPUtilities()
        let requestBuilder: NewsRequestBuilder = NewsRequestBuilder()
        return NewsRepository(httpUtility: httpUtility, newRequestBuilder: requestBuilder)
    }
    
    func getNewsArticle(limit: String) async throws -> Article? {
        let getArticleRequest = newRequestBuilder.fetchArticleData(limit: limit)
        guard let articleRequest = getArticleRequest else {
            return nil
        }
        guard let article: Article = try? await httpUtility.execute(request: articleRequest) else {
            return nil
        }
        return article
    }
}
