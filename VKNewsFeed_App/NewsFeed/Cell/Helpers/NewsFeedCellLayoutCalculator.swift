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
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    
    var bottomView: CGRect
    var totalHeight: CGFloat
    
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes
}

final class NewsFeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {

    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes {
        var showMoreTextButton = false
        
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
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: - Work with moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInserts.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        
        //MARK: - Work with attachmentFrame
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : moreTextButtonFrame.maxY + Constants.postLabelInserts.bottom
        
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
            moreTextButtonFrame: moreTextButtonFrame,
            attachmentFrame: attachmentFrame,
            bottomView: bottomViewFrame,
            totalHeight: totalHeight)
    }
}
