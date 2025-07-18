//
//  DataObjects.swift
//  ReelDeel
//
//  Created by kumara.c on 18/07/25.
//
import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String // Using Emoji for icons as in HTML mock
    let videoCount: Int
}

struct Video: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let category: String
    let sharedSource: String
    let sharedDate: Date
    let thumbnailImageUrl: String // Changed from thumbnailName to URL for flexibility
    let tags: [String]
    let originalUrl: String? // Added for "Open Original Video"
}
