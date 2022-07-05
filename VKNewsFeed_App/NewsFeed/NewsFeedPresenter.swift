//
//  NewsFeedPresenter.swift
//  VKNewsFeed_App
//
//  Created by Феликс Титов on 7/5/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
      switch response {

      case .presentNewsFeed(let feed):
          let cells = feed.items.map { feedItem in
              cellViewModel(from: feedItem)
          }
          
          let feedViewModel = FeedViewModel(cells: cells)
          viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
      }
  }
  
    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
        FeedViewModel.Cell(
            iconURLString: "",
            name: "Future name",
            date: "Future datw",
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0)
        )
    }
}
