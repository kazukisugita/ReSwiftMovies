
import Foundation
import Alamofire
import RxSwift

class MoviesListViewModel: ViewModel, Injectable {
    
    typealias InjectionContainer = HasStore & HasNetworkService
    var injectionContainer: InjectionContainer

    init(with injectionContainer: InjectionContainer) {
        self.injectionContainer = injectionContainer
    }
    
    func fetchMovieList() {
    }
    
    func setAsCheckedMovie(movieID: Int) {
    }
}
