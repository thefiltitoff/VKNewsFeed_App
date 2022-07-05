//
//  ViewController.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .red
    }

    @IBAction func signInButton(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

