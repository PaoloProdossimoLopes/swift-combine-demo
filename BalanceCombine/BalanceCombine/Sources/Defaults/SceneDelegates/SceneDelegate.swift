//
//  SceneDelegate.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Properties
    private var appScenes: [UIWindowSceneDelegate] = []

    //MARK: - UIWindowSceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        handleScene(scene, willConnectTo: session, options: connectionOptions)
    }

    func sceneDidDisconnect(_ scene: UIScene) { /*No use*/ }
    func sceneDidBecomeActive(_ scene: UIScene) { /*No use*/ }
    func sceneWillResignActive(_ scene: UIScene) { /*No use*/ }
    func sceneWillEnterForeground(_ scene: UIScene) { /*No use*/ }
    func sceneDidEnterBackground(_ scene: UIScene) { /*No use*/ }
}

//MARK: - Helpers

private extension SceneDelegate {
    
    func registerScenes() {
        let listOfScenes = makeSceneList()
        listOfScenes.forEach { appScenes.append($0) }
    }
    
    func makeSceneList() -> [UIWindowSceneDelegate] {
        let coordinatorScene = SceneCoordinatorDelegate()
        return [coordinatorScene]
    }
    
    func handleScene(_ scene: UIScene, willConnectTo session: UISceneSession,
                     options connectionOptions: UIScene.ConnectionOptions) {
        registerScenes()
        appScenes.forEach { delegate in
            delegate.scene?(scene, willConnectTo: session, options: connectionOptions)
        }
    }
}
