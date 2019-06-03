
import Foundation
import ReSwift
import RxSwift

let AppMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { _action in
            
            guard let action = _action as? AppActions.MovieList.startLoadingMovies else {
                return next(_action)
            }
            
            let disposeBag = CompositeDisposable()
            let disposable = networkService.fetch(withRoute: Routes.discoverMovie)
                .asObservable()
                .map { $0.movies.filter { $0.backdropPath != nil }}
                .subscribe(onNext: { fetchedMovies in
                    dispatch(AppActions.MovieList.loadMovies(movies: fetchedMovies))
                    disposeBag.dispose()
                })
            _ = disposeBag.insert(disposable)
        }
    }
}
