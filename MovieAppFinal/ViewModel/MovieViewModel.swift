//
//  File.swift
//  MovieAppFinal
//
//  Created by Liuning Weng on 12/16/21.
//

import Foundation

class MovieViewModel {
    
    private var movieService = MovieService()
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        movieService.getPopularMoviesData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}

