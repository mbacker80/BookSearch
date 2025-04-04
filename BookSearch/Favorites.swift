//
//  Favorites.swift
//  BookSearch
//
//  Created by James Jolly on 4/3/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: BookViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.favorites) { book in
                HStack {
                    // Display book cover
                    if (book.coverId != nil)
                    {
                        AsyncImage(url: URL(string: book.coverImgUrl)!) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 75)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(book.title).font(.headline)
                        Text(book.author?.joined(separator: ", ") ?? "Unkown Author").font(.subheadline)
                    }
                }
            }
            .onDelete(perform: delete)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        viewModel.favorites.remove(atOffsets: offsets)
    }
}
