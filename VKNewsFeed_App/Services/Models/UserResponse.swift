//
//  UserResponse.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/8/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
