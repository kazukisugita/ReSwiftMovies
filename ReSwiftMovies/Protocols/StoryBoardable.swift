
import UIKit

protocol StoryBoardable {}

extension StoryBoardable where Self: UIViewController {
    
    static func instanceFromSB() -> Self {
        return UIStoryboard.init(name: self.className, bundle: nil).instantiateInitialViewController() as! Self
    }
}
