import Foundation
import Swinject

let DIContainer = AppDIContainer.shared

///`AppDIContainer` is responsible to create/manage all dependencies of the application.
final class AppDIContainer {
    static let shared = AppDIContainer()
    
    // MARK:- Private Properties
    
    private let container = Container()
    
    // MARK:- Init
    
    private init(){
        //Register dependencies
        
        container.register(NetworkService.self) { _  in URLSession.shared }.inObjectScope(.container)
        container.register(GiphyUseCase.self) { resolver  in
            guard let service = resolver.resolve(NetworkService.self) else {
                fatalError("NetworkService dependency not found!")
            }
            
            return NetworkGiphyUseCase(service: service)
        }.inObjectScope(.container)
        
    }
    
    /// Generic function which will resolve the dependency of type T.
    /// - Returns: object of type T from the container.
    func resolve<T>() -> T {
        guard let object = container.resolve(T.self) else {
            fatalError("Can't resolve dependency of type \(T.self) ")
        }
        
        return object
    }
}
