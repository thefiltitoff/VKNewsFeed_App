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
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
            
        case .presentNewsFeed(let feed, let revealPostIds):
            let cells = feed.items.map { feedItem in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealPostIds: revealPostIds)
            }
            
            let feedViewModel = FeedViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        case .presentUserInfo(user: let user):
            let userViewModel = UserViewModel(photoUSRLString: user?.photo100)
            viewController?.displayData(viewModel: .displayUser(userViewModel: userViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealPostIds: [Int]) -> FeedViewModel.Cell {
        let profile = profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealPostIds.contains { postID in
            postID == feedItem.postId
        }
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        
        return FeedViewModel.Cell(
            postId: feedItem.postId,
            iconURLString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0),
            photoAttachments: photoAttachments,
            sizes: sizes
        )
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { myProfileRepresentable in
            myProfileRepresentable.id == normalSourceId
        }
        
        return profileRepresentable!
    }
    
    //Declared
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        if let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first {
            
            return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.srcBIG , height: firstPhoto.height, width: firstPhoto.width)
        } else if let photo = feedItem.attachments?.compactMap({ attachment in
            attachment.link?.photo
        }), let firstPhoto = photo.first {
            return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.srcBIG , height: firstPhoto.height, width: firstPhoto.width)
        } else {
            return nil
            
        }
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        if let attachments = feedItem.attachments {
            var photos = attachments.compactMap { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
                guard let photo = attachment.photo else { return nil }
                return FeedViewModel.FeedCellPhotoAttachment(
                    photoUrlString: photo.srcBIG ,
                    height: photo.height,
                    width: photo.width
                )
            }
            
            if photos.isEmpty {
                photos = attachments.compactMap { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
                    guard let photo = attachment.link?.photo else { return nil }
                    return FeedViewModel.FeedCellPhotoAttachment(
                        photoUrlString: photo.srcBIG ,
                        height: photo.height,
                        width: photo.width
                    )
                }
            }
            return photos
            
        }  else {
            return []
        }
    }
}
