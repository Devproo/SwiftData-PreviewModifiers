//
//  BookCommentView.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 28/12/2024.
//

import SwiftUI
import SwiftData

struct BookCommentView: View {
    @Bindable var book: Book
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            Text(book.name)
                .font(.title)
            Text(book.allAuthors)
                .font(.title3)
            Text(book.genre.name)
                .tag(book.genre.color)
            TextField("Comment", text: $book.comment, axis: .vertical)
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    BookCommentView(book: Book(name: "", genre: Genre(name: "", color: ""), authors: []))
}
