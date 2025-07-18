//
//  SharedURLs.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
//
import SwiftUI

class SharedURLs: ObservableObject {
    @Published var urlsList: [String] = ["google.com"]
    
    func addUrlToList(_ url: String) {
        urlsList.append(url)
    }
}
