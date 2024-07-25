//
//  SwiftUI_NewsAppApp.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 15/07/24.
//

import SwiftUI

@main
struct SwiftUI_NewsAppApp: App {
    
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
