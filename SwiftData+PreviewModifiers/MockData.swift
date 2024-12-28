//
//  MockDataPreviewTraits.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 28/12/2024.
//

import SwiftUI
import SwiftData

struct MockData: PreviewModifier {
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
    
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try! ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let importData = ImportModel.fetchMockData()
        
        importData?.genres.forEach({ genreI in
            let genre  = Genre(name: genreI.name, color: genreI.color)
            container.mainContext.insert(genre)
        })
        importData?.authors.forEach({ authorI in
            let author = Author(firstName: authorI.firstName, lastName: authorI.lastName)
            container.mainContext.insert(author)
        })
        let genres = try? container.mainContext.fetch(FetchDescriptor<Genre>())
        let authors = try? container.mainContext.fetch(FetchDescriptor<Author>())
        
        if let genres, let authors {
            importData?.books.forEach{ bookI in
                guard let genre = genres.first(where: {$0.name == bookI.genre}) else {
                    print("\(bookI.name) not found")
                    return
                }
                let book = Book(name: bookI.name, genre: genre)
                genre.books.append(book)
                
                bookI.authorIds.forEach { authorId in
                    guard let author = authors.first(where: {$0.fullName == authorId  }) else {
                        print("\(authorId) not founr")
                        return
                    }
                    book.authors.append(author)
                }
                container.mainContext.insert(book)
            }
        }
        return container
    }
    
}

extension PreviewTrait where  T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockData())
}
