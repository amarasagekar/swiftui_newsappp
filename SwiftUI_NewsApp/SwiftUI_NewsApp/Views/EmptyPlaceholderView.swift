//
//  EmptyPlaceholderView.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 20/07/24.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    
    let text: String
    let image: Image?
    
    var body: some View{
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    EmptyPlaceholderView(text: "No Bookmark", image: Image(systemName: "bookmark"))
}
