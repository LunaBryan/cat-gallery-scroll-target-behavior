//
//  ContentView.swift
//  cat-gallery-scroll-target-behavior
//
//  Created by Jose Luna on 5/25/25.
//

import SwiftUI

private enum Constants {
    
    static let containerLeadingPadding: CGFloat = 8
    
    enum Image {
        static let widthPercentage: CGFloat = 0.95
        static let height: CGFloat = 550
    }
    
    enum ProgressView {
        static let scaleEffect: CGFloat = 2
    }
}

struct ContentView: View {
    
    private let urlStrings: [String] = [
        "https://www.pawsbyzann.com/wp-content/uploads/2022/08/Christmas-Final-copy.jpg",
        "https://i.pinimg.com/736x/1d/b9/d7/1db9d7a79f35dfb23e373a7a963764b9.jpg",
        "https://www.angiewallacefineart.com/wp-content/uploads/2024/04/Mog1.jpg",
        "https://img.freepik.com/premium-photo/lovely-cats_161021-835.jpg",
        "https://img.freepik.com/premium-photo/portrait-cat_1048944-19869996.jpg",
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: .zero) {
                ForEach(urlStrings, id: \.self) {
                    AsyncImage(url: url(from: $0)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                        } else if phase.error != nil {
                            Color.gray
                        } else {
                            ProgressView()
                                .tint(.blue)
                                .scaleEffect(Constants.ProgressView.scaleEffect)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * Constants.Image.widthPercentage)
                    .frame(height: Constants.Image.height)
                }
                .padding(.horizontal, Constants.containerLeadingPadding)
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
    // MARK: - Url builder
    
    private func url(from string: String) -> URL {
        guard let url = URL(string: string)
        else { fatalError() }
        
        return url
    }
}

#Preview {
    ContentView()
}
