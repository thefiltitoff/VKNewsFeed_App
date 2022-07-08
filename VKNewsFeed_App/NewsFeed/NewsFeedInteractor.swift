//
//  NewsFeedInteractor.swift
//  VKNewsFeed_App
//
//  Created by Феликс Титов on 7/5/22.
//  Copyright (c) 2022 . All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
      
      switch request {
          
      case .getNewsFeed :
          fetcher.getFeed { [weak self] feedResponse in
              self?.feedResponse = feedResponse
              self?.presentFeed()
          }
      case .revealPostsId(postId: let postId):
          revealedPostIds.append(postId)
          presentFeed()
      case .getUser:
          fetcher.getUser { userResponse in
              self.presenter?.presentData(response: .presentUserInfo(user: userResponse))
          }
      }
  }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return  }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
    }
  
}
