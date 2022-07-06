//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/6/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

struct Sizes: FeedCellSizes {
    
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    
    var bottomView: CGRect
    var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

struct Constants {
    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
}

final class NewsFeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {

    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
        
        //MARK: - Work with postLabelFrame
        
        var postLabelFrame = CGRect(
            origin: CGPoint(
                x: Constants.postLabelInserts.left,
                y: Constants.postLabelInserts.top
            ),
            size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: - Work with attachmentFrame
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : postLabelFrame.maxY + Constants.postLabelInserts.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let photoAttachment = photoAttachment {
            let ratio = CGFloat(Float(photoAttachment.height) / Float(photoAttachment.width))
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        //MARK: - Work with bottomView
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(
            origin: CGPoint(x: 0, y: bottomViewTop),
            size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        //MARK: - Work with totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        return Sizes(
            postLabelFrame: postLabelFrame,
            attachmentFrame: attachmentFrame,
            bottomView: bottomViewFrame,
            totalHeight: totalHeight)
    }
}
