//
//   v.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import Foundation

struct PhotoItem {
    let thumbnailURL: URL
    let imageURL: URL
    let description: String?
    let likesNumber: Int
    let user: User
    
    struct User {
        let fullName: String
        let userName: String
        let thumbnailURL: URL
        let bio: String
    }
}
