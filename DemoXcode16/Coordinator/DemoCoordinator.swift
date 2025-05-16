//
//  DemoCoordinator.swift
//  DemoXcode16
//
//  Created by Admin on 16/05/2025.
//
import UIKit

final class DemoCoordinator: Coordinator<Void> {
    
    private(set) var navigation: UINavigationController?
    private(set) var completion: CoordinatorCompletion?

    init(root: UINavigationController) {
        self.navigation = root
    }

    override func start(completion: @escaping CoordinatorCompletion) {
       
        self.completion = completion
        var viewModel: DemoViewModelType = DemoViewModel()
        let vc = DemoViewController()
        vc.viewModel = viewModel
       
        NavigationControllerFactory.configureNavigationItem(for: vc, title: "DemoXCode")
        
        guard let navigation else {
            completion(.failure(.unknown))
            return
        }
        navigation.pushViewController(vc, animated: true)
        
        viewModel.output.naviagteToSignatoryView = {
            [weak self] item in
            guard let self = self else { return }
            self.navigateToSignatoryView(item)
        }

        // Optionally call completion when needed
        // For now, complete immediately
        //completion(.success(()))
    }
    
    func navigateToSignatoryView(_ item: DemoItem) {
        guard let navigation else {
            completion?(.failure(.unknown))
            return
        }
        let signatoryCoordinator = SignatoryCoordinator(root: navigation, item: item)
        coordinate(to: signatoryCoordinator) { result in
            switch result {
            case .success:
                // Handle success if needed
                break
            case .failure(let error):
                // Handle error if needed
                print("Error navigating to SignatoryView: \(error)")
            }
        }
    }
}
