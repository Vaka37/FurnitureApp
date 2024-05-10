//
//  TabView.swift
//  FurnitureApp
//
//  Created by Vakil on 08.05.2024.
//

import SwiftUI

struct TabUIView: View {
    var body: some View {
        NavigationView {
            TabView {
                GoodsView()
                    .tabItem {
                        Label("", systemImage: "storefront")
                    }
                
                UserView()
                    .tabItem {
                        Label("", systemImage: "face.smiling")
                    }
            }
            .accentColor(Color.green.opacity(0.5))
        }
    }
}

#Preview {
    TabUIView()
}
