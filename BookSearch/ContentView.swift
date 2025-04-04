//
//  ContentView.swift
//  BookSearch
//
//  Created by James Jolly on 4/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BookViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            TabView {
                SearchView(viewModel: viewModel)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                FavoritesView(viewModel: viewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
            }
            .frame(maxHeight: .infinity)
            
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
