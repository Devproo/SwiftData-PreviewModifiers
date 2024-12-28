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
    @Relationship(inverse: \Book.genre)
    var  books: [Book]
    
    var colorStyle: Color {
        switch color.lowercased() {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "yellow": return .yellow
        case "black": return .black
        case "white": return .white
        default: return .gray
        }
    }
    
    var textColor: Color {
        colorStyle == .white || colorStyle == .yellow ? .black : .white
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
