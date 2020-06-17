//
//  AppDelegate.swift
//  GroceryListClient
//
//  Created by Mikhail Kuzmin on 17.06.2020.
//  Copyright © 2020 Mikhail Kuzmin All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let navigationController = UINavigationController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupWindow(with: navigationController)
        navigationController.pushViewController(
            makeModule(),
            animated: true
        )

        return true
    }

    private func setupWindow(with rootViewController: UINavigationController) {
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = rootViewController
      window?.makeKeyAndVisible()
    }

    private func makeModule() -> UIViewController {
        let groceryListService = GroceryListServiceImpl(host: Constants.host, port: Constants.port)
        let viewModel = ViewModelImpl(groceryListService: groceryListService)
        let viewController = ViewController(viewModel: viewModel)

        return viewController
    }

}

private extension AppDelegate {

    struct Constants {

        static let host = "localhost"
        static let port = 8000

    }

}

