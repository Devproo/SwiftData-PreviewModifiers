//
//  ContentView.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 27/12/2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    var body: some View {
        TabView {
            Tab("Books", systemImage: "books.vertical"){
                BooksView()
            }
            Tab("Authors", systemImage: "person.3.sequence") {
                AuthorView()
            }
            Tab("Genre", systemImage: "swatchpalette") {
                GenreView()
            }
        }
    }
}

#Preview(traits: .mockData) {
    MainView()
}
