//
//  TabBarItem.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
//
import SwiftUI

struct TabBarItem: View {
    let iconName: String
    let label: String
    let tabName: TabItem
    @Binding var selectedTab: TabItem
    
    var body: some View {
        Button(action: {
            selectedTab = tabName
        }) {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                Text(label)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(selectedTab == tabName ? .blue : .gray)
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: TabItem = .search
    TabBarItem(iconName: "magnifyingglass", label: "Search", tabName: .home, selectedTab: $selectedTab)
}
