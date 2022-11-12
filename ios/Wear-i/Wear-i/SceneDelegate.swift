//
//  SceneDelegate.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        
        let base = UINavigationController(rootViewController: LoginViewController())
        self.window?.rootViewController = base //rootViewController 설정(맨 처음 보여질 것)
        
    }
    
}
