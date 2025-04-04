//
//  Search.swift
//  BookSearch
//
//  Created by James Jolly on 4/3/25.
//

import SwiftUI


struct SearchView: View {
    @ObservedObject var viewModel: BookViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                TextField("Search Books", text: $viewModel.searchQuery, onCommit: {
                    viewModel.searchBooks()
                })
                
                Button(action:  {
                    viewModel.searchBooks()
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .clipShape(Circle())
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            List(viewModel.searchResults) { book in
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
                        Text(book.author?.joined(separator: ", ") ?? "Uknown Author").font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.toggleFavorite(book: book)
                    }) {
                        Image(systemName: viewModel.favorites.contains(book) ? "heart.fill" : "heart")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}
