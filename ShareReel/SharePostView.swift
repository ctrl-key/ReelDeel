//
//  SharePostView.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
//

import SwiftUI

struct SharePostView: View {
    @State var sharedUrl: URL
    var delegate: SharePostViewDelegate?
    init(url: URL, delegate: SharePostViewDelegate? = nil) {
        self.sharedUrl = url
        self.delegate = delegate
    }
    var body: some View {
        NavigationStack {
            Text("URL: \(sharedUrl)")
            Button {
                delegate?.sharePostToTheApp(sharedUrl)
                delegate?.sharePostViewClose()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(height: 300)
        .navigationTitle("Share the reels to ReelDeal")
        .toolbar {
            Button("Cancel") {
                delegate?.sharePostViewClose()
            }
        }
    }
}

protocol SharePostViewDelegate: AnyObject {
    func sharePostViewClose()
    func sharePostToTheApp(_ url: URL)
}
