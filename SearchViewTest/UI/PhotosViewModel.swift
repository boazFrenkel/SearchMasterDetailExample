//
//  PhotosTableViewModel.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 30/01/2021.
//

import Foundation

class PhotosViewModel {
    typealias Observer<T> = (T) -> Void
    private var dataLoader: PhotosLoader
    
    var loadedFeed: [PhotoItem] = []  {
        didSet {
            self.onPhotosLoaded?(loadedFeed)
        }
    }
    
    var onPhotosLoaded: Observer<[PhotoItem]>?
    var onLoadingStateChange: Observer<Bool>?
    
    init(dataLoader: PhotosLoader) {
        self.dataLoader = dataLoader
    }
    
    func search(_ : String) {
        self.loadPhotos()
    }
    
    private func loadPhotos() {
        onLoadingStateChange?(true)
        
        dataLoader.load({[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let photos):
                self.loadedFeed = photos
            case .failure(let error):
                //TODO: handle errors showing on UI
                print(error)
            }
            self.onLoadingStateChange?(false)
        })
    }
    
}
