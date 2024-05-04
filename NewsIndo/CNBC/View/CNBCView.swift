//
//  CNBCView.swift
//  NewsIndo
//
//  Created by User50 on 23/04/24.
//

import SwiftUI
import SafariServices

struct CNBCView: View {
    @StateObject private var cnbcnewsVM = CNBCNewsVM()
    @State private var searchText: String = ""
    @State private var isRedacted: Bool = true
    
    var CNBCSearch: [CNBCArticle] {
        guard !searchText.isEmpty else {
            return cnbcnewsVM.articles
        }
        return cnbcnewsVM.articles.filter{
            $0.title.lowercased().contains(searchText.lowercased())
        }
        
    }
    
    var body: some View {
        NavigationStack{
            
            List{
            
                if isRedacted{
                    ForEach(CNBCSearch){article in
                        HStack(spacing:16){
                            AsyncImage(url: URL(string: article.image.large)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ZStack{
                                    WaitingView()
                                }
                            
                            }

                            
                            VStack (alignment:.leading){
                                Text(article.title)
                                    .font(.headline)
                                Text(article.contentSnippet)
                                    .font(.subheadline)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                
                            }
                            
                        }
                        .onTapGesture {
                            let vc = SFSafariViewController(url: URL(string: article.link)!)
                            UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc,animated: true)
                        }
                        
                    }
                    .redacted(reason: .placeholder)
                }else {
                    ForEach(CNBCSearch){article in
                        HStack(spacing:16){
                            AsyncImage(url: URL(string: article.image.large)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                
                            } placeholder: {
                                ZStack{
                                    WaitingView()
                                }
                                
                            }

                            
                            VStack (alignment:.leading){
                                Text(article.title)
                                    .font(.headline)
                                Text(article.contentSnippet)
                                    .font(.subheadline)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                
                            }
                            
                        }
                        .onTapGesture {
                            let vc = SFSafariViewController(url: URL(string: article.link)!)
                            UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc,animated: true)
                        }
                        
                    }
                }
                
            }
            .navigationTitle("CNBC News")
            .listStyle(.plain)
            .refreshable {
                isRedacted = true
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2)
                {
                    isRedacted = false
                }
            }
            .onAppear{
                //melakukan pararel proses agar ui tetap berjalan saat
                //suatu proses belum selesai
                DispatchQueue.main
                    .asyncAfter(deadline: .now() + 2){
                        isRedacted = false
                    }
            }
            .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode:.always),
            prompt: "What emoji's that you're looking for?"
            )
            .overlay {
                if CNBCSearch.isEmpty{
                    ContentUnavailableView.search(text: searchText)
                    }
                }
        }
        .task {
            await cnbcnewsVM.fetchNewsCNBC()
        }
    }
}


#Preview {
    CNBCView()
}

