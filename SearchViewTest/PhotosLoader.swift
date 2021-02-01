//
//  PhotosLoader.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import Foundation

protocol PhotosLoader {
    typealias Result = Swift.Result<[PhotoItem], Error>
    func load(_ completion: @escaping (Result) -> Void)
}
