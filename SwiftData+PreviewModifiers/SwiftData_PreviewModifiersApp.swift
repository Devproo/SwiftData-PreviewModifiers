//
//  SwiftData_PreviewModifiersApp.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 27/12/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftData_PreviewModifiersApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Book.self)
    }
}
