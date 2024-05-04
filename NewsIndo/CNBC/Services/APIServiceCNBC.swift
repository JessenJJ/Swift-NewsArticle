//
//  APIServiceCNBC.swift
//  NewsIndo
//
//  Created by User50 on 23/04/24.
//

import Foundation
import Alamofire

class APIServiceCNBC {
    static let shared = APIServiceCNBC()
    
    private init(){}
    
    func fetchNewsCNBC() async throws -> [CNBCArticle]{
        guard let url = URL(string: ConstantCNBC.newsUrl)
        else {
            throw URLError(.badURL)
        }
        
        let newsCNBC = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable ( of:CNBC.self){ response in
            switch response.result{
            case .success(let newsResponse):
                continuation.resume(returning: newsResponse.data)
            case .failure(let error):
                continuation.resume(throwing: error)
                }
            }
        }
        return newsCNBC
        
    }
}
