//
//  PhotosTableViewModel.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 30/01/2021.
//

import Foundation

protocol PhotosLoader {
    typealias Result = Swift.Result<[PhotoItem], Error>
    func load(_ completion: @escaping (Result) -> Void)
}

struct PhotoItem {
    let imageURL: URL
    let description: String
}

class PhotosViewModel {
    typealias Observer<T> = (T) -> Void
    var dataLoader: PhotosLoader
    
    
    var onPhotosLoaded: Observer<[PhotoItem]>?
    var onLoadingStateChange: Observer<Bool>?
    
    init(dataLoader: PhotosLoader) {
        self.dataLoader = dataLoader
    }
    
    func loadPhotos() {
        onLoadingStateChange?(true)
        
        dataLoader.load({[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let photos):
                self.onPhotosLoaded?(photos)
            case .failure(let error):
                //TODO: handle errors showing on UI
                print(error)
            }
            self.onLoadingStateChange?(false)
        })
    }
    
    func search(_ : String) {
        
    }
    
}
