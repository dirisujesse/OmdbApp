//
//  MovieListViewModel.swift
//  OmdbApp
//
//  Created by Dirisu on 01/09/2022.
//

import Foundation

struct MovieViewModel {
    let movie: Movie
    
    var imdbId: String {
        movie.imdbId
    }
    
    var title: String {
        movie.title
    }
    
    var poster: String {
        movie.poster
    }
    
    var year: String {
        movie.year
    }
}

class MovieListViewModel: ObservableObject {
    @Published var movies = [MovieViewModel]();
    private let httpClient = HttpClient();
    
    func getMovies(_ title: String = "BatMan") async {
        do {
            let moviesList = try await httpClient.getMoviesBy(search: title)
            
            DispatchQueue.main.async {
                self.movies = moviesList.map(MovieViewModel.init)
            }
        } catch {
            print("No Data")
        }
    }
}
