//
//  TagStyle.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 30/12/2024.
//

import Foundation

import SwiftUI

struct TagStyle: ViewModifier{
    let genre: Genre
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(genre.textColor)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(genre.colorStyle))
    }
}
extension View {
    func tagStyle(genre: Genre) -> some View {
        modifier(TagStyle(genre: genre))
    }
}
