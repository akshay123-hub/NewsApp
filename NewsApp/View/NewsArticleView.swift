//
//  ContentView.swift
//  NewsApp
//
//  Created by Akshay Kumar on 09/03/26.
//

import SwiftUI
import WebKit

struct NewsArticleView: View {
    @State var newsViewModel = NewsArticleViewModel()
    let background: some View = LinearGradient(colors: [.red.opacity(0.2), .blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
        .blur(radius: 40)
        .ignoresSafeArea()
    var body: some View {
        NavigationStack {
            ZStack {
                background
                List(newsViewModel.article.data, id: \.id) { article in
                    NavigationLink {
                        WebView(url: URL(string: article.url))
                    } label: {
                        ArticleRowView(data: article)
                    }

                }
                if newsViewModel.isLoading{
                    ProgressView("Loading...")
                }
            }
            .onAppear {
                Task {
                    try await loadArticleData()
                }
            }
            .alert("Error", isPresented: .constant(newsViewModel.errorMessage != nil), actions: {
                Button {
                    newsViewModel.errorMessage = nil
                } label: {
                    Text("OK")
                }

            }, message: {
                Text(newsViewModel.errorMessage ?? "")
            })
            .navigationTitle("Top Headlines")
            .refreshable {
                Task {
                    try await loadArticleData()
                }
            }
        }
    }
    
    private func loadArticleData() async throws {
        newsViewModel.isLoading = true
        print("Call \(Int.random(in: 0...10))")
        try await newsViewModel.getArticleData(limit: "3")
        newsViewModel.isLoading = false
    }
}

#Preview {
    NewsArticleView()
}
