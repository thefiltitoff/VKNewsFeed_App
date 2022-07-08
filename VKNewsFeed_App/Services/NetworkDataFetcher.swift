//
//  NetworkDataFetcher.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    private var authService: AuthService
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
           
            let decoded = decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let user_id = authService.userID else { return }
        let params = ["user_ids": user_id, "fields": "photo_100"]
        
        networking.request(path: API.user, params: params) { data, error in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoded = decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let data = data,
                let response = try? decoder.decode(type.self, from: data)
        else { return nil }
        
        
        return response
    }
}


