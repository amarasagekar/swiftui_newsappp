//
//  RetryView.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 20/07/24.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction, label: {
                Text("Try Again")
            })
        }
    }
}

#Preview {
    RetryView(text: "An error ocurred") {
        
    }
}
