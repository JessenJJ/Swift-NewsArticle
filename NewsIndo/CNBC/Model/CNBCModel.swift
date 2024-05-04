//
//  CNBCModel.swift
//  NewsIndo
//
//  Created by User50 on 23/04/24.
//

import Foundation

// MARK: - Welcome
struct CNBC: Codable {
    let message: String
    let total: Int
    let data: [CNBCArticle]
}

// MARK: - Datum
struct CNBCArticle: Codable, Identifiable {
    var id: String { link }
    let title: String
    let link: String
    let contentSnippet, isoDate: String
    let image: ImageCNBC
}

// MARK: - Image
struct ImageCNBC: Codable {
    let small, large: String
}
