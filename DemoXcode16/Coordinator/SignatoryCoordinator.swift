//
//  SignatoryCoordinator.swift
//  DemoXcode16
//
//  Created by Admin on 13/05/2025.
//
import UIKit

final class SignatoryCoordinator: Coordinator<Void> {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start(completion: @escaping (Result<Void, CoordinatorError>) -> Void) {
        let viewModel: SignatoryListViewModelType = SignatoryListViewModel()
        let vc = SignatoryListViewController()
        vc.viewModel = viewModel

        navigationController.pushViewController(vc, animated: true)

        // Optionally call completion when needed
        // For now, complete immediately
        completion(.success(()))
    }
}
