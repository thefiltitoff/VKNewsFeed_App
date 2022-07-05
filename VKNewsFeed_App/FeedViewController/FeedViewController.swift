//
//  FeedViewController.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class FeedViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getFeed()
        view.backgroundColor = .systemBlue
    }
    


}
