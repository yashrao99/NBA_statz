//
//  PlayerClass.swift
//  NBAstatz
//
//  Created by Yash Rao on 4/27/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit


struct PlayerInformation {
    
    var personID = Int64(0)
    var name = ""
    var startYear = ""
    var teamID = Int64(0)
    var city = ""
    var team = ""
    var teamThreeLetter = ""
    
    init(array: NSArray) {
        
        self.personID = (array[0] as? Int64)!
        self.name = (array[2] as? String)!
        self.startYear = (array[4] as? String)!
        self.teamID = (array[7] as? Int64)!
        self.city = (array[8] as? String)!
        self.team = (array[9] as? String)!
        self.teamThreeLetter = (array[10] as? String)!
    }
}
