//
//  CNBCNewsVM.swift
//  NewsIndo
//
//  Created by User50 on 23/04/24.
//

import Foundation

@MainActor
class CNBCNewsVM: ObservableObject {
    @Published var articles = [CNBCArticle]()
    @Published var isLoading = false
    @Published var errorMessages: String?
    
    func fetchNewsCNBC() async {
        isLoading = true
        
        // defer sama dengan menutup isLoading menjadi false
        // defer{ isLoading = false}
        errorMessages = nil
        
        do {
            articles = try await    APIServiceCNBC.shared.fetchNewsCNBC()
            isLoading = false
        } catch {
            errorMessages = "👻 \(error.localizedDescription).Failed to fetch News from API!!! 👻"
            print(errorMessages ?? "N/A")
            isLoading = false
        }
    }
}
