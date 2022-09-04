//
//  ContentView.swift
//  OmdbApp
//
//  Created by Dirisu on 31/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MoviesListScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
