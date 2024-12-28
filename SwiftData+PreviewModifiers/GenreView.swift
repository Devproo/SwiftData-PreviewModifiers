//
//  GenreTabView.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 28/12/2024.
//

import SwiftUI
import SwiftData

struct GenreView: View {
    @Query(sort: \Genre.name) var genres: [Genre]
    var body: some View {
        NavigationStack {
            List(genres) { genre in
                HStack {
                    Text(genre.name)
                    Spacer()
                    Text("^[\(genre.books.count)](inflect: true)")
                }
                .listRowBackground(genre.colorStyle)
                .foregroundStyle(genre.textColor)
                
            }
            .navigationTitle("Genres")
        }
    }
}

#Preview {
    GenreView()
}
