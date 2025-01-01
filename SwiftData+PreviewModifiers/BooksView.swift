//
//  BooksTabView.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 28/12/2024.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
    case book, genre
    var id: Self { self }
}

enum FilterType: String, Identifiable, CaseIterable {
    case book, genre, author
    var id: Self { self }
}

struct BooksView: View {
    @State private var sortOrder = SortOrder.book
    @State private var filterType = FilterType.book
    @State private var filter = ""
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Picker("Sort Order", selection: $sortOrder) {
                        ForEach(SortOrder.allCases) { SortOrder in
                            Text("sorted by\(sortOrder)")
                            
                        }
                    }
                    
                    Spacer()
                    Picker("Filter Type", selection: $filterType) {
                        ForEach(FilterType.allCases) { filterType in
                            Text("filtered by\(filterType)")
                        }
                    }
                }
                .buttonStyle(.bordered)
                .padding(.horizontal)
                
                BookListView(
                    sortOrder: sortOrder,
                    filterType: filterType,
                    filter: filter
                )
            }
            .searchable(text: $filter, prompt: "Enter search word")
            .navigationTitle("Books")
        }
    }
}

#Preview(traits: .mockData) {
    BooksView()
}
