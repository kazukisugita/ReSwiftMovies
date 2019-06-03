
import Foundation
import ReSwift

struct AppActions {
    
    struct MovieList {}
    struct MovieDetail {}
    struct CheckedMovies {}
}

extension AppActions.MovieList {
    
    struct startLoadingMovies: Action {}
    
    struct loadMovies: Action {
        let movies: [DiscoverMovieModel]
    }
}

extension AppActions.MovieDetail {
    
    struct loadDetail: Action {
        let movieID: Int
    }
}

extension AppActions.CheckedMovies {
    
    struct addChecked: Action {
        let movie: DiscoverMovieModel
    }
}
