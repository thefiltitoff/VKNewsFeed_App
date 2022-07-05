//
//  FeedViewController.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class FeedViewController: UIViewController {
    
    private let networkService: Networking = NetworkService()
    
    override func viewDidLoad() {
        let params = ["filters": "post,photo"]
        super.viewDidLoad()
        networkService.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json)

        }
        view.backgroundColor = .systemBlue
    }
}
