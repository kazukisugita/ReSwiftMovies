
import Foundation
import ReSwift

protocol HasStore {
    var store: Store<AppState> { get }
}

protocol HasNetworkService {
    var networkService: NetworkService { get }
}
