//
//  ContentView.swift
//  jhx
//
//  Created by Alexandru Cantor on 10.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            AsyncImageURL(urlString: "https://images.unsplash.com/photo-1549740425-5e9ed4d8cd34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80", maxWidth: 100).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Image {
    func loadImageURL(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)

        }
        return self
    }
}

