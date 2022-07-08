//
//  NewsFeedModels.swift
//  VKNewsFeed_App
//
//  Created by Феликс Титов on 7/5/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case getUser
                case revealPostsId(postId: Int)
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse, revealedPostIds: [Int])
                case presentUserInfo(user: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
                case displayUser(userViewModel: UserViewModel)
            }
        }
    }
}

struct UserViewModel: TitleViewViewModel {
    var photoUSRLString: String?
    
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        
        var postId: Int
        var iconURLString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
        
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var height: Int
        var width: Int
    }
    
    let cells: [Cell]
}


