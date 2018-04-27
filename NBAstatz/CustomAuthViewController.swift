//
//  CustomAuthViewController.swift
//  NBAstatz
//
//  Created by Yash Rao on 3/1/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuthUI

class CustomAuthViewController: FUIAuthPickerViewController, FUIAuthDelegate {
    
    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth) {
        super.init(nibName: "FUIAuthPickerViewController", bundle: bundle, authUI: authUI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "Vino")
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 150, width:UIScreen.main.bounds.size.width, height: 150))
        welcomeLabel.text = "Mamba Mentality"
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont(name: "SnellRoundhand-Black", size: 30.0)
        
        let loginLabel = UILabel(frame: CGRect(x: 0, y: 50, width:UIScreen.main.bounds.size.width, height: 150))
        loginLabel.text = "PLEASE LOGIN"
        loginLabel.textAlignment = .center
        loginLabel.textColor = UIColor.white
        loginLabel.font = UIFont(name: "MarkerFelt-Wide", size: 30.0)
        
        view.insertSubview(imageViewBackground, at: 0)
        view.insertSubview(welcomeLabel, at: 1)
        view.insertSubview(loginLabel, at: 1)
    }
}
