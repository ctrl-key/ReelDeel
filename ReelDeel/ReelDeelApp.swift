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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sharedUrls)
                .onOpenURL { url in
                    if let sharedDefaults = UserDefaults(suiteName: "group.com.genai.reelDeel"),
                       let urlString = sharedDefaults.string(forKey: "sharedURL"),
                       let url = URL(string: urlString) {
                        sharedUrls.addUrlToList(url.absoluteString)
                        sharedDefaults.removeObject(forKey: "sharedURL") // optional: clear after read
                    }
                }
        }
    }
}
