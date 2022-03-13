import UIKit.UIViewController

/// The `BaseCoordinator` is provides basic/abstract implementation of navigations.
/// it is responsible to manage the presentation logic of view controllers.
/// subclass can override `start` implementation for their specific presentation logic.
class BaseCoordinator<T: UIViewController>: NSObject, Coordinator {
    let rootViewController: T

    var child: Coordinator?

    weak var parent: Coordinator?
    
    //MARK: - init
    
    init(rootViewController: T) {
        self.rootViewController = rootViewController
    }
    
    //MARK: - Public Methods
    
    /// show first view controller
    func start() {
        assertionFailure("child class must override it.")
    }
}
