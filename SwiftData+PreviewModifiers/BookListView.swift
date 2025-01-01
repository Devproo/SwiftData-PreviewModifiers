//
//  BookListView.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 31/12/2024.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Query var books: [Book]
    @State private var selectedBook: Book?
    init(sortOrder: SortOrder, filterType: FilterType, filter: String) {
        let sortDescriptors = sortOrder == .book
            ? [SortDescriptor(\Book.name)]
            : [SortDescriptor(\Book.genre.name)]
        
        let predicate: Predicate<Book> = filter.isEmpty
            ? #Predicate { _ in true }
            : {
                switch filterType {
                case .book: return #Predicate { $0.name.localizedStandardContains(filter) }
                case .genre: return #Predicate { $0.genre.name.localizedStandardContains(filter) }
                case .author:
                    let authorMatch = #Expression<[Author], Int> {
                        $0.filter { $0.firstName.localizedStandardContains(filter) || $0.lastName.localizedStandardContains(filter) }.count
                    }
                    return #Predicate { !$0.authors.isEmpty && authorMatch.evaluate($0.authors) > 0 }
                }
            }()
        
        _books = Query(filter: predicate, sort: sortDescriptors)
    }

    var body: some View {
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
    }
}

#Preview(traits: .mockData) {
    let sortOrder = SortOrder.book
    let filterType = FilterType.book
    let filter = ""
    BookListView(
        sortOrder: sortOrder,
        filterType: filterType,
        filter: filter
    )
}
