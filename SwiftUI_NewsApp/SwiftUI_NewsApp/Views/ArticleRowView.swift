//
//  ArticleRowView.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 18/07/24.
//

import SwiftUI

struct ArticleRowView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    let article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            AsyncImage(url: article.imageURL) {
                phase in
                switch phase {
                case .empty:
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .failure:
                    HStack{
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                    
                default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button(action: {
                        toggleBookmark(for: article)
                    }, label: {
                        Image(systemName: articleBookmarkVM.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                    })
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        presentShareSheet(url: article.articleUrl)
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
                    .buttonStyle(.bordered)
                }
            })
            .padding([.horizontal, .bottom])
            
        })
    }
    
    private func toggleBookmark(for article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
}

extension View {
    func presentShareSheet(url: URL){
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}

#Preview {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel()
    NavigationView {
        List{
            ArticleRowView(article: .previewData[0])
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
    .environmentObject(articleBookmarkVM)
}
