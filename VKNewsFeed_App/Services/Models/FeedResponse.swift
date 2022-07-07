//
//  FeedResponse.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//


import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct Attachment: Decodable {
    let photo: Photo?
    let link: Link?
}

struct Link: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return getPropperSize().height
    }
    
    var width: Int {
        return getPropperSize().width
    }
    
    var srcBIG: String {
        getPropperSize().url
    }
    
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "z" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
        
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: ProfileRepresentable, Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String { return firstName + " " + lastName}
    var photo: String { return photo100 }
}

struct Group: ProfileRepresentable, Decodable {
    var photo: String { return photo100 }
    
    let id: Int
    let name: String
    let photo100: String
}

struct CountableItem: Decodable {
    let count: Int
}
