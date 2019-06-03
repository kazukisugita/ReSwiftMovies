
import UIKit
import ReSwift

let store = Store<AppState>(
    reducer: appReducers,
    state: nil,
    middleware: [AppMiddleware]
)

 let networkService: NetworkService = NetworkService(withBaseUrl: URL(string: "https://api.themoviedb.org/3/")!, andApiKey: "3afafd21270fe0414eb760a41f2620eb")


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

