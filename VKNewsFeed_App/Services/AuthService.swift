//
//  AuthService.swift
//  VKNewsFeed_App
//
//  Created by Felix Titov on 7/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    
    private let appID = AppDelegate.appId
    private let vkSDK: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        VKSdk.forceLogout()
        vkSDK = VKSdk.initialize(withAppId: appID)
        super.init()
        
        print("VKSdk.initialized")
        
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { [delegate] state, error in
            switch state {
            case .initialized:
                print("Initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("Authorized")
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
                print(error!.localizedDescription)
                break
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
