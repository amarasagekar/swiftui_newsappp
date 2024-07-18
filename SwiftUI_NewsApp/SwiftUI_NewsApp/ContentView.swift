//
//  ContentView.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 15/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArticleListView(articles: Article.previewData)
    }
}

#Preview {
    ContentView()
}
