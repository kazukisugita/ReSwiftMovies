
import UIKit

protocol ViewModel {}

protocol ViewModelBased {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}

extension ViewModelBased where Self: UIViewController {
    
    static func instanceFromCode(with viewModel: ViewModelType) -> Self {
        var viewController = self.init()
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func instanceFromSB(with viewModel: ViewModelType) -> Self {
        var viewController = UIStoryboard.init(name: self.className, bundle: nil).instantiateInitialViewController() as! Self
        viewController.viewModel = viewModel
        return viewController
    }
}
