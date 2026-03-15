//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Akshay Kumar on 15/03/26.
//

import SwiftUI

struct ArticleRowView: View {
    var data: Datum
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: data.imageURL)) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.thickMaterial)
                        .overlay {
                            ProgressView()
                        }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(let error):
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.thinMaterial)
                        .overlay {
                            ProgressView()
                        } 
                @unknown default:
                    EmptyView()
                }
                
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 8) {
                Text(data.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(data.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                Text(data.publishedAt)
                    .font(.caption)
                    .foregroundStyle(.primary)
                
                
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    ArticleRowView(data: Datum.init(title: "Some Title", description: "Description of new title", url: "", imageURL: "", publishedAt: ""))
}
