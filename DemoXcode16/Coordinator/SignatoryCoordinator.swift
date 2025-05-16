//
//  SignatoryCoordinator.swift
//  DemoXcode16
//
//  Created by Admin on 13/05/2025.
//
import UIKit

final class SignatoryCoordinator: Coordinator<Void> {
    
    private(set) var navigation: UINavigationController?

    init(root: UINavigationController) {
        self.navigation = root
    }

    override func start(completion: @escaping (Result<Void, CoordinatorError>) -> Void) {
        let viewModel: SignatoryListViewModelType = SignatoryListViewModel()
        let vc = SignatoryListViewController()
        NavigationControllerFactory.configureNavigationItem(
            for: vc,
            title: "DemoXcode16",
            showBackButton: true,
            onBack: { [weak navigation] in navigation?.popViewController(animated: true) },
            rightButton: UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        )
        vc.viewModel = viewModel

        guard let navigation else {
            completion(.failure(.unknown))
            return
        }
        navigation.pushViewController(vc, animated: true)

        // Optionally call completion when needed
        // For now, complete immediately
        completion(.success(()))
    }
}
