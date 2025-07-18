//
//  CategoryCard.swift
//  ReelDeel
//
//  Created by kumara.c on 18/07/25.
//

import SwiftUI

/// A card view for displaying a video category.
struct CategoryCard: View {
    var category: Category
    
    var body: some View {
        HStack(spacing: 15) {
            Text(category.icon) // Emoji icon
                .font(.title)
                .frame(width: 48, height: 48)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(category.name)
                    .font(.headline)
                    .foregroundColor(Color(.label))
                
                Text("\(category.videoCount) videos")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    let category = Category(name: "Nature", icon: "🌿", videoCount: 2)
    CategoryCard(category: category)
}
