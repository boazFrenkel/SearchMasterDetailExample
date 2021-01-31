//
//  PhotoListUIComposer.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import UIKit

class PhotoListUIComposer {
    static func infoComposedWith(photosLoader: PhotosLoader) -> PhotosViewController {
        let photosController = makePhotosViewController(photosLoader: photosLoader)
        return photosController
    }
    
    private static func makePhotosViewController(photosLoader: PhotosLoader) -> PhotosViewController {
        let bundle = Bundle(for: PhotosViewController.self)
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: bundle)
        let photosViewModel = PhotosViewModel(dataLoader: photosLoader)
        let photosViewController = storyboard.instantiateInitialViewController() as! PhotosViewController
        photosViewController.photosViewModel = photosViewModel
        
        return photosViewController
    }
}
