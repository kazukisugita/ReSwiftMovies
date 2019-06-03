
import Foundation
import ReSwift

struct AppState: StateType {
    
    var movieListState: MovieListState
    var movieDetailState: MovieDetailState
    var checkedMoviesState: CheckedMoviesState
}

struct MovieListState: StateType {
    var movies: [DiscoverMovieModel] = []
}

struct MovieDetailState: StateType {
    var movie: DiscoverMovieModel?
}

struct CheckedMoviesState: StateType {
    var movies: [DiscoverMovieModel] = []
}
