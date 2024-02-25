//
//  News.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import Foundation

// MARK: - News
struct News: Codable {
    let articles: [Article]
}
// MARK: - Article
struct Article: Codable {
    let title: String
    let description: String?
    let urlToImage: String?
    let content: String?
}
