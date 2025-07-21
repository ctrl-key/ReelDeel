//
//  VideoDataService.swift
//  ReelDeel
//
//  Created by kumara.c on 20/07/25.
//

import SwiftData

@Observable class VideoDataService {
    static let shared = VideoDataService()
    var modelContext: ModelContext?
    
    func add(_ newVideoData: VideoDataModel) {
        if let context = modelContext {
            context.insert(newVideoData)
            do {
                try context.save()
                print("context saved")
            } catch {
                print("there is error while saving context")
            }
        }
    }
}
