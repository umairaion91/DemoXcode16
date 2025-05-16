//
//  NavigationFactory.swift
//  DemoXcode16
//
//  Created by Admin on 16/05/2025.
//

import UIKit

enum NavigationControllerFactory {
    
    static func makeTransparentNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController.navigationBar.compactScrollEdgeAppearance = appearance
        }
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
    
    static func makeOpaqueNavigationController(backgroundColor: UIColor = .systemBackground) -> UINavigationController {
        let navigationController = UINavigationController()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = nil
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController.navigationBar.compactScrollEdgeAppearance = appearance
        }
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
    
    // MARK: - Configure Navigation Item
    
    /// Configures the navigation item of the given view controller
    /// - Parameters:
    ///   - viewController: The view controller whose navigation item to configure.
    ///   - title: The navigation bar title.
    ///   - showBackButton: Whether to show a custom back button.
    ///   - backButtonImage: Optional custom back image (default is system chevron).
    ///   - onBack: Closure to execute on back button tap.
    ///   - rightButton: Optional right bar button item.
    static func configureNavigationItem(
        for viewController: UIViewController,
        title: String? = nil,
        showBackButton: Bool = false,
        backButtonImage: UIImage? = nil,
        onBack: (() -> Void)? = nil,
        rightButton: UIBarButtonItem? = nil
    ) {
        viewController.navigationItem.title = title
        
        if showBackButton {
            let backImage = backButtonImage ?? UIImage(
                systemName: "chevron.backward",
                withConfiguration: UIImage.SymbolConfiguration(weight: .medium)
            )
            let backButton = UIBarButtonItem(image: backImage, style: .plain, target: nil, action: nil)
            backButton.actionHandler = onBack // see UIBarButtonItem+ActionHandler extension below
            viewController.navigationItem.leftBarButtonItem = backButton
        } else {
            viewController.navigationItem.leftBarButtonItem = nil
        }
        
        viewController.navigationItem.rightBarButtonItem = rightButton
    }
}
