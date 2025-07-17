//
//  TabBarView.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
//
import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack {
            Spacer()
            TabBarItem(iconName: "house.fill", label: "Home", tabName: .home, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(iconName: "folder.fill", label: "Categories", tabName: .categories, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(iconName: "magnifyingglass", label: "Search", tabName: .search, selectedTab: $selectedTab)
            Spacer()
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
    }
}

#Preview {
    @Previewable @State var selectedTab: TabItem = .search
    TabBarView(selectedTab: $selectedTab)
}
