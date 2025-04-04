//
//  Book.swift
//  BookSearch
//
//  Created by James Jolly on 4/3/25.
//

import SwiftUI

struct Book: Identifiable, Codable, Equatable {
    let coverId: Int?
    //let hasFullText: Bool?
    //let editionCount: Int?
    let title: String
    let author: [String]?
    //let firstPublishYear: Int?
    let id: String
    //let ia: [String]
    //let authorKey: [String]
    //let publicScanB: Bool?
    
    enum CodingKeys: String, CodingKey {
        case coverId = "cover_i"
        //case hasFullText = "has_fulltext"
        //case editionCount = "edition_count"
        case title = "title"
        case author = "author_name"
        //case firstPublishYear = "first_publish_year"
        case id = "key"
        //case ia = "ia"
        //case authorKey = "author_key"
        //case publicScanB = "public_scan_b"
    }
    
    init(coverId: Int?, title: String, author: [String]?, key: String) {
        self.coverId = coverId
        //self.hasFullText = hasFullText ?? false
        //self.editionCount = editionCount
        self.title = title
        self.author = author!
        //self.firstPublishYear = firstPublishYear
        self.id = key
        //self.ia = ia!
        //self.authorKey = authorKey!
        //self.publicScanB = publicScanB!
        
        
    }
    
    var coverImgUrl: String {
        return "https://covers.openlibrary.org/b/id/\(coverId ?? 0)-S.jpg"
    }
}

class BookViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var searchResults: [Book] = []
    @Published var favorites: [Book] = []
    
    func searchBooks() {
        guard !searchQuery.isEmpty else { return }
        
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let urlString = "https://openlibrary.org/search.json?q=\(encodedQuery)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    self.searchResults = decodedResponse.docs
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
    
    func toggleFavorite(book: Book) {
        if let index = favorites.firstIndex(of: book) {
            favorites.remove(at: index)
        } else {
            favorites.append(book)
        }
    }
}

struct SearchResponse: Codable {
    let docs: [Book]
}
