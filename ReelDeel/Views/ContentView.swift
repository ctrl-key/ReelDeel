//
//  ContentView.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
//

import SwiftUI

struct ContentView: View {
    @State var links: [String] = ["spider man", "iron man", "thor"]
    @EnvironmentObject var sharedUrls: SharedURLs
    var body: some View {
        VStack {
            ForEach(sharedUrls.urlsList, id: \.self) {
                Text($0).padding(.all, 10)
                    .background(.yellow)
            }
        }
        .padding(25)
        .background(.blue)
    }
}

#Preview {
    @Previewable @StateObject var sharedUrls = SharedURLs()
    ContentView().environmentObject(sharedUrls)
}
