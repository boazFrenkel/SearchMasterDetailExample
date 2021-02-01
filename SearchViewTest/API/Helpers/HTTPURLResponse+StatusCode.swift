//
//  HTTPURLResponse+StatusCode.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
