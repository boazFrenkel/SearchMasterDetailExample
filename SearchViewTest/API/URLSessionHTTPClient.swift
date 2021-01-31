//
//  URLSessionHTTPClient.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 31/01/2021.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValues: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(Result {
                    if let error = error {
                        throw error
                    } else if let data = data, let response = response as? HTTPURLResponse {
                        return (data, response)
                    } else {
                        throw UnexpectedValues()
                    }
                })
            }
            
        }.resume()
    }
}

