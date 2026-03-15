//
//  NewsArticleViewModel.swift
//  NewsApp
//
//  Created by Akshay Kumar on 10/03/26.
//

import Foundation
protocol NewsArticleViewModelProtocol: AnyObject {
    func getArticleData(limit: String) async throws
}

@Observable
final class NewsArticleViewModel: NewsArticleViewModelProtocol {
    
    var article: Article = Article(data: [])
    var errorMessage: String?
    var isLoading = false
    private var repository: NewsRepositoryProtocol
    
    init( repository: NewsRepositoryProtocol = NewsRepository.defaultRepository) {
        self.repository = repository
    }
    
    @MainActor
    func getArticleData(limit: String) async throws {
        guard let data = try await repository.getNewsArticle(limit: limit) else {
            errorMessage = "Data is Empty..."
            return
        }
        article = data
    }
}
