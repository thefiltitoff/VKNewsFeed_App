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
                case some
                case getFeed
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentNewsFeed
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayNewsFeed
            }
        }
    }
    
}
