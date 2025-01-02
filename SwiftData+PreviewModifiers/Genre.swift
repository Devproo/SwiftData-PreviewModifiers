//
//  Genre.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 27/12/2024.
//

import SwiftUI
import SwiftData

@Model
class Genre {
    @Attribute(.unique)
    var name: String
    var color: String
    @Relationship(deleteRule: .cascade ,inverse: \Book.genre)
    var books: [Book]
    
    // Computed property used to determine the foreground style for Genre tag
    var colorStyle: Color {
        Color(hex: color)!
    }
    var textColor: Color {
        colorStyle.adaptedTextColor()
    }
    
    init(name: String, color: String, books: [Book]) {
        self.name = name
        self.color = color
        self.books = books
    }
  
    convenience init(name: String, color: String) {
        self.init(name: name, color: color, books: [])
    }
    
}
