//
//  DataObjects.swift
//  ReelDeel
//
//  Created by kumara.c on 18/07/25.
//
import SwiftUI
import SwiftData

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

struct VideoData: Codable {
    let audioKeywords, broaderCategories, textKeywords: [String]
    let title: String
    let topCategories: [String]
    let uploader: String
    let url: String
    let visualTags: [String]

    enum CodingKeys: String, CodingKey {
        case audioKeywords = "audio_keywords"
        case broaderCategories = "broader_categories"
        case textKeywords = "text_keywords"
        case title
        case topCategories = "top_categories"
        case uploader, url
        case visualTags = "visual_tags"
    }
}

@Model
class VideoDataModel {
    private var identifier = UUID()
    var videoUrl: String
    init(videoUrl: String) {
        self.videoUrl = videoUrl
    }
}
