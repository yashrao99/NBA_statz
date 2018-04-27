//
//  MainController.swift
//  NBAstatz
//
//  Created by Yash Rao on 3/1/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class MainViewController: UIViewController {

    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    var user: User?
    var displayName: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuth()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureAuth() {
        
        let provider: [FUIAuthProvider] = [FUIGoogleAuth()]
        FUIAuth.defaultAuthUI()?.providers = provider
        
        _authHandle = Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) in
            
            if let activeUser = user {
                if self.user != activeUser {
                    self.user = activeUser
                    let name = user!.email!.components(separatedBy: "@")[0]
                    self.displayName = name
                    
                }
            } else {
                self.loginSession()
            }
        }
        
    }
    
    func loginSession() {
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }


}

