//
//  ContentView.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var links: [String] = ["spider man", "iron man", "thor"]
    //Get you DataBase context here. Created based on the model container we pass
    @Environment(\.modelContext) var context
    @Query(sort:\VideoDataModel.videoUrl) var videoList: [VideoDataModel]
    var body: some View {
        List {
            ForEach(videoList, id: \.self) {
                Text($0.videoUrl).padding(.all, 10)
                    .background(.yellow)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    print("able to access delete")
                }
            }
        }
        .padding(25)
        .background(.black)
    }
}

#Preview {
    @Previewable @StateObject var sharedUrls = SharedURLs()
    ContentView().environmentObject(sharedUrls)
}
