//
//  SceneCoordinatorDelegate.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import UIKit

final class SceneCoordinatorDelegate: NSObject, Coordinator {
    
    //MARK: - Properties
    
    var window: UIWindow?
    private(set) var childrens: [Coordinator] = []
    
    //MARK: - Methods
    
    func start() {
        window?.rootViewController = makeScene()
        window?.makeKeyAndVisible()
    }
}

//MARK: - Helpers

private extension SceneCoordinatorDelegate {
    func makeScene() -> ViewController {
        let service = BalanceService()
        let contentView = BalanceView()
        let viewModel = BalanceViewModel(service: service)
        let controller = ViewController(contentView: contentView, viewModel: viewModel)
        return controller
    }
}

//MARK: - UIWindowSceneDelegate

extension SceneCoordinatorDelegate: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        start()
    }
}
