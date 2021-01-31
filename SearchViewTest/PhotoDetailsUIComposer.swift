//
//  PhotoDetailsUIComposer.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import UIKit

class PhotoDetailsUIComposer {
    static func infoComposedWith(item: PhotoItem) -> PhotoDetailsViewController {
        let photosController = makePhotoDetailsViewController(item: item)
        return photosController
    }
    
    private static func makePhotoDetailsViewController(item: PhotoItem) -> PhotoDetailsViewController {
        let bundle = Bundle(for: PhotoDetailsViewController.self)
        let storyboard = UIStoryboard(name: Constants.photoDetailsStoryboardName, bundle: bundle)
        let photoDetailsViewController = storyboard.instantiateInitialViewController() as! PhotoDetailsViewController
        photoDetailsViewController.photoDetails = item
        
        return photoDetailsViewController
    }
}
