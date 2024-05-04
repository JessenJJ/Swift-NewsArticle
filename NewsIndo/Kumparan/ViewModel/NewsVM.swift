//
//  NewsVM.swift
//  NewsIndo
//
//  Created by User50 on 23/04/24.
//

import Foundation

@MainActor
class NewsVM: ObservableObject {
    @Published var articles = [NewsArticle]()
    @Published var isLoading = false
    @Published var errorMessages: String?
    
    func fetchNews() async {
        
        isLoading = true
        
        // defer sama dengan menutup isLoading menjadi false
        // defer{ isLoading = false}
        errorMessages = nil
        
        do {
            articles = try await APIService.shared.fetchNews()
            isLoading = false
        } catch {
            errorMessages = "👻 \(error.localizedDescription).Failed to fetch News from API!!! 👻"
            print(errorMessages ?? "N/A")
            isLoading = false
        }
    }
}
