//
//  ReelDeelApp.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
//

import SwiftUI
import SwiftData

@main
struct ReelDeelApp: App {
    @StateObject var sharedUrls = SharedURLs()
    let sharedModelContainer: ModelContainer = {
        let groupID = "group.com.genai.reelDeel" // Replace with your actual App Group ID
        let grpContainer = ModelConfiguration.GroupContainer.identifier(groupID)
        //let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupID)!
        let config = ModelConfiguration(groupContainer: grpContainer)
        
        do {
            let container = try ModelContainer(for: VideoDataModel.self, configurations: config)
            VideoDataService.shared.modelContext = container.mainContext
            return container
        } catch {
            fatalError("Failed to create shared ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sharedUrls)
        }.modelContainer(sharedModelContainer)
    }
}
