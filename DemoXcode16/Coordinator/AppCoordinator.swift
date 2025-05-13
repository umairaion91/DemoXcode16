//
//  AppCoordinator.swift
//  DemoXcode16
//
//  Created by Admin on 13/05/2025.
//
import UIKit

final class AppCoordinator: Coordinator<Void> {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start(completion: @escaping (Result<Void, CoordinatorError>) -> Void) {
        
        let navController = UINavigationController()
        window.rootViewController = navController
        window.makeKeyAndVisible()

        let signatoryCoordinator = SignatoryCoordinator(navigationController: navController)

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

