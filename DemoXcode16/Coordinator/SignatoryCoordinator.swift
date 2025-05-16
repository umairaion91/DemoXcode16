//
//  SignatoryCoordinator.swift
//  DemoXcode16
//
//  Created by Admin on 13/05/2025.
//
import UIKit

final class SignatoryCoordinator: Coordinator<Void> {
    
    private(set) var navigation: UINavigationController?
    private(set) var item: DemoItem

    init(root: UINavigationController, item: DemoItem) {
        self.navigation = root
        self.item = item
    }

    override func start(completion: @escaping (Result<Void, CoordinatorError>) -> Void) {
        let viewModel: SignatoryListViewModelType = SignatoryListViewModel()
        let vc = SignatoryListViewController()
        NavigationControllerFactory.configureNavigationItem(
            for: vc,
            title: item.name,
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
    }
}
