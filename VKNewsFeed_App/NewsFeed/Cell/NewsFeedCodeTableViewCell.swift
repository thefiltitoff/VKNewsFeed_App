//
//  NewsFeedCodeTableViewCell.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/7/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

protocol NewsfeedCodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedCodeTableViewCell)
}

final class NewsFeedCodeTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsFeedCodeTableViewCell"
    
    weak var delegate: NewsfeedCodeCellDelegate?
    
    //MARK: - First layer's prooperties
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Second layer's prooperties
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UITextView = {
        let label = UITextView()
        let padding = label.textContainer.lineFragmentPadding
        
        label.isScrollEnabled = false
        label.isSelectable = true
        label.isUserInteractionEnabled = true
        label.isEditable = false

        label.dataDetectorTypes = UIDataDetectorTypes.all
        label.font = Constants.postLabelFont
        label.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        label.backgroundColor = .clear
        label.textColor = .label
        return label
    }()
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4012392163, green: 0.6231879592, blue: 0.8316264749, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - Third layer's prooperties on topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    //MARK: - Third layer's prooperties on bottomView
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Fourth layer's prooperties on bottomView
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle =  .none
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchDown)
        contentView.isUserInteractionEnabled = true
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnTopView()
        overlayThirdLayerOnBottomView()
        overlayFourthLayerOnBottomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        
        //cardView constraints
        cardView.fillSuperview(padding: Constants.cardInserts)
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        
        
        //topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true

    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        //iconImageView constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        //nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
        //dateLabel constraints
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
    }
    
    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        //likesView constraints
        likesView.anchor(
            top: bottomView.topAnchor,
            leading: bottomView.leadingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //commentsView constraints
        commentsView.anchor(
            top: bottomView.topAnchor,
            leading: likesView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //sharesView constraints
        sharesView.anchor(
            top: bottomView.topAnchor,
            leading: commentsView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //viewsView constraints
        viewsView.anchor(
            top: bottomView.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: bottomView.trailingAnchor,
            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
    }
    
    private func overlayFourthLayerOnBottomView() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        setConstarintsforFouthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        setConstarintsforFouthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        setConstarintsforFouthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        setConstarintsforFouthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    private func setConstarintsforFouthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        // imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        // label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconURLString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomView
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
}
