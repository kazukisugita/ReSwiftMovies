
import Foundation
import ReSwift

func appReducers(action: Action, state _state: AppState?) -> AppState {
    return AppState(
        movieListState: movieListReducer(action: action, state: _state?.movieListState),
        movieDetailState: movieDetailReducer(action: action, state: _state),
        checkedMoviesState: checkedMoviesReducer(action: action, state: _state?.checkedMoviesState)
    )
}

func movieListReducer(action: Action, state _state: MovieListState?) -> MovieListState {
    
    var state = _state ?? MovieListState()
    
    switch action {
        
    case let loadMovies as AppActions.MovieList.loadMovies:
        state.movies = loadMovies.movies
        
    default:
        break
    }
    
    return state
}

func movieDetailReducer(action: Action, state _state: AppState?) -> MovieDetailState {
    
    guard var state = _state else { return MovieDetailState() }
    
    switch action {
    case let loadDetail as AppActions.MovieDetail.loadDetail:
        
        let _movie = state.movieListState.movies.filter { $0.id == loadDetail.movieID }.first
        if let movie = _movie {
            state.movieDetailState.movie = movie
        }
    default:
        break
    }
    
    return state.movieDetailState
}

func checkedMoviesReducer(action: Action, state _state: CheckedMoviesState?) -> CheckedMoviesState {
    
    guard var state = _state else { return CheckedMoviesState() }
    
    switch action {
    case let checked as AppActions.CheckedMovies.addChecked:
        
        if state.movies.contains(checked.movie) {
            let duplicated = state.movies.enumerated().filter { $0.element == checked.movie }
            if let offset = duplicated.first?.offset {
                state.movies.remove(at: offset)
            }
        }
        state.movies.insert(checked.movie, at: 0)
        
    default:
        break
    }
    
    return state
}
