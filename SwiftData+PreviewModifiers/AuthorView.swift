//
//  AuthorTabView.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 28/12/2024.
//

import SwiftUI
import SwiftData

struct AuthorView: View {
    @Query(sort: \Author.lastName) var authors: [Author]
    var body: some View {
        NavigationStack {
            List(authors) { author in
                HStack {
                    Text(author.fullName)
                    Spacer()
                    Text("^[\( author.books.count)](inflict: true)")
                }
            }.navigationTitle("Authors")
        }
    }
}

#Preview(traits: .mockData) {
    AuthorView()
}
