//
//  SceneDelegate.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 29/01/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private lazy var navigationController: UINavigationController = UINavigationController(rootViewController: compose())
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        window?.rootViewController = navigationController
    }
    
    private func compose() -> PhotosViewController {
        let remoteURL = URL(string: Constants.stubURLString)!
        let remoteClient = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let remotePhotosLoader = RemotePhotosLoader(url: remoteURL, httpClient: remoteClient)
        
        let photosViewController = PhotoListUIComposer.infoComposedWith(photosLoader: remotePhotosLoader)
        photosViewController.selectedPhoto = {item in
            let photoDetailsViewController = PhotoDetailsUIComposer.infoComposedWith(item: item)
            self.navigationController.pushViewController(photoDetailsViewController, animated: true)
        }
        return photosViewController
    }
    
}

