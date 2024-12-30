//
//  BooksTabView.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 28/12/2024.
//

import SwiftUI
import SwiftData

struct BooksView: View {
    @Query(sort: \Book.name) var books: [Book]
       @State private var selectedBook: Book?
       var body: some View {
           NavigationStack {
               List(books) { book in
                   VStack(alignment: .leading) {
                       HStack {
                           Text(book.name)
                               .font(.title)
                           Spacer()
                           Text(book.genre.name)
                               .tagStyle(genre: book.genre)
                       }
                       HStack {
                           Text(book.allAuthors)
                           Spacer()
                           Button {
                               selectedBook = book
                           } label: {
                               Image(systemName: "message")
                                   .symbolVariant(book.comment.isEmpty ? .none : .fill)
                           }
                           .buttonStyle(.plain)
                       }
                   }
               }
               .listStyle(.plain)
               .sheet(item: $selectedBook) { book in
                   BookCommentView(book: book)
                       .presentationDetents([.height(300)])
               }
               .navigationTitle("Books")
           }
       }
}

#Preview(traits: .mockData) {
    BooksView()
}
