
import UIKit

protocol ViewModel {}

protocol ViewModelBased {}

extension ViewModelBased where Self: UIViewController {
    
    static func instanceFromSB() -> Self {
        return UIStoryboard.init(name: self.className, bundle: nil).instantiateInitialViewController() as! Self
    }
}
