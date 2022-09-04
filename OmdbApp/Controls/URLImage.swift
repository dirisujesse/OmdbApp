//
//  URLImage.swift
//  URLImageDemo
//
//  Created by Mohammad Azam on 6/17/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct URLImage: View {
    
    let url: URL?

    
    init(url: String) {
        self.url = URL(string: url)
    }
    
    var body: some View {
        AsyncImage(url: url, content: { image in
            image.resizable()
                .frame(maxWidth: 70, maxHeight: 100)
                .cornerRadius(10)
                .aspectRatio(contentMode: .fit)
        },
        placeholder: {
            ProgressView()
                .frame(maxWidth: 70, maxHeight: 100)
        })
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://fyrafix.files.wordpress.com/2011/08/url-8.jpg")
    }
}
