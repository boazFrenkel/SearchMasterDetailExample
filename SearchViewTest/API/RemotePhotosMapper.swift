//
//  RemotePhotosMapper.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel
//

import Foundation

class RemotePhotosMapper {
    private struct Container: Decodable {
        var results: [RemotePhotoItemDTO]
    }
    
    private struct RemotePhotoItemDTO: Decodable {
        let description: String?
        let likesNumber: Int
        let user: RemoteUser
        let urls: [String: URL]
        
        var thumbnailURL: URL {
            return urls["thumb"]!
        }
        
        var imageURL: URL {
            return urls["regular"]!
        }
        enum CodingKeys: String, CodingKey {
            case description = "alt_description"
            case likesNumber = "likes"
            case user
            case urls
        }
        
        struct RemoteUser: Decodable {
            let fullName: String
            let userName: String
            let profileImage: [String: URL]
            let bio: String?
            
            enum CodingKeys: String, CodingKey {
                case fullName = "name"
                case userName = "username"
                case profileImage = "profile_image"
                case bio
            }
            
            var thumbnailURL: URL {
                return profileImage["small"]!
            }
        }
        
        var photoItem: PhotoItem {
            PhotoItem(thumbnailURL: thumbnailURL, imageURL: imageURL, description: description, likesNumber: likesNumber, user: photoItemUser)
        }
        
        private var photoItemUser: PhotoItem.User {
            PhotoItem.User(fullName: user.fullName, userName: user.userName, thumbnailURL: user.thumbnailURL, bio: user.bio ?? "")
        }
    }
    
    static func map(data: Data, response: HTTPURLResponse) throws -> [PhotoItem] {
        guard response.isOK , let containerResponse = try? JSONDecoder().decode(Container.self, from: data) else {
            throw RemotePhotosLoader.RemoteError.invalidData
        }
        return containerResponse.results.map {  $0.photoItem }
    }
}
