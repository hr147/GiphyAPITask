import UIKit

extension UIStoryboard {
    enum Name: String {
        case giphy = "Giphy"
        case giphyDetail = "GiphyDetail"
    }
    
    convenience init(name: Name, bundle: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: bundle)
    }
    
    func initialViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("Could not locate view controller in storyboard.")
        }
        
        return viewController
    }
}
