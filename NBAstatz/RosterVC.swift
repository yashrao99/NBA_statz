//
//  RosterVC.swift
//  NBAstatz
//
//  Created by Yash Rao on 3/3/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class RosterVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = MasterNetwork.sharedInstance().buildURL("commonallplayers", ["LeagueID":"00", "Season":"2017-18", "IsOnlyCurrentSeason": "1"])
        MasterNetwork.sharedInstance().getRoster(url) { success,parsedResult, error in
            if success {
                print("yee")
                let test = parsedResult!["resultSets"] as! NSArray
                let test1 = test[0] as! [String:AnyObject]
                let test2 = test1["rowSet"] as! [NSArray]
                print(test2)
            } else {
                print("nah")
            }
        }
        
    }
}
