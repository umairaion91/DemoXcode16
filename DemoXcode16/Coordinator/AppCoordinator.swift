//
//  AppCoordinator.swift
//  DemoXcode16
//
//  Created by Admin on 13/05/2025.
//
import UIKit

final class AppCoordinator: Coordinator<Void> {
    
    private let window: UIWindow
    private(set) var root: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    override func start(completion: @escaping (Result<Void, CoordinatorError>) -> Void) {
        //NavigationControllerFactory.makeTransparentNavigationController()
        root = NavigationControllerFactory.makeOpaqueNavigationController(backgroundColor: .systemBackground)
        window.rootViewController = root
        window.makeKeyAndVisible()
        
        guard let root else { return }
        let signatoryCoordinator = SignatoryCoordinator(root: root)

        coordinate(to: signatoryCoordinator) { result in
            switch result {
            case .success:
                completion(.success(())) // Or do something else like restart app flow
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

