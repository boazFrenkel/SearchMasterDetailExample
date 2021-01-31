//
//  RemotePhotosLoader.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import Foundation

class RemotePhotosLoader: PhotosLoader {
    private let client: HTTPClient
    private let url: URL
    
    enum RemoteError: Error {
        case connectivity
        case invalidData
    }
    
    init(url: URL, httpClient: HTTPClient) {
        self.url = url
        self.client = httpClient
    }
    
    func load(_ completion: @escaping (PhotosLoader.Result) -> Void) {
        client.get(from: url) { (result) in
            switch result {
            case .success((let data, let response)):
                let photosResult = RemotePhotosLoader.map(data, from: response)
                completion(photosResult)
                
            case .failure(_):
                completion(.failure(RemoteError.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> PhotosLoader.Result {
        do {
            let photos = try RemotePhotosMapper.map(data: data, response: response)
            return .success(photos)
        } catch {
            return .failure(error)
        }
    }
}
