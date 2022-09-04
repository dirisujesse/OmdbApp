//
//  MoviesListScreen.swift
//  OmdbApp
//
//  Created by Dirisu on 01/09/2022.
//

import SwiftUI

struct MoviesListScreen: View {
    @StateObject private var moviesViewModel = MovieListViewModel()
    @State private var movieName: String = ""
    @State private var loading: Bool = false
    
    var body: some View {
        VStack {
            TextField("Enter movie name", text: $movieName, onCommit: {
                Task {
                    loading = true
                    await moviesViewModel.getMovies(movieName.trim())
                    loading = false
                    movieName = ""
                }
            })
            .textFieldStyle(.roundedBorder)
            .padding()
            Spacer()
            if (moviesViewModel.movies.count > 0 && !loading) {
                MovieList(movies: moviesViewModel.movies)
            }
            if (moviesViewModel.movies.count <= 0 && !loading) {
                Text("Search for a movie")
            }
            if (loading) {
                ProgressView()
            }
            Spacer()
        }
        .navigationTitle("Movies")
    }
}

struct MoviesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoviesListScreen()
        }
    }
}

struct MovieList: View {
    let movies: [MovieViewModel]
    
    var body: some View {
        List {
            ForEach(movies, id: \.imdbId) { MovieCell(movie: $0) }
        }
    }
}

struct MovieCell: View {
    let movie: MovieViewModel
    
    var body: some View {
        NavigationLink(destination: {
            Text(movie.title)
                .navigationTitle(movie.title)
                .navigationBarTitleDisplayMode(.inline)
        }) {
            HStack(alignment: .center, spacing: 10) {
                URLImage(url: movie.poster)
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.year)
                        .font(.body)
                }
                Spacer()
            }
            .padding(.vertical)
        }
    }
}
