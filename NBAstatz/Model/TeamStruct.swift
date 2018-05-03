//
//  TeamStruct.swift
//  NBAstatz
//
//  Created by Yash Rao on 5/2/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit


struct TeamStruct {
    
    var city = ""
    var name = ""
    var threeLetter = ""
    var conference = ""
    var division = ""
    var wins = Int64(0)
    var losses = Int64(0)
    var winPct = 0.00
    var confRank = Int64(0)
    var divRank = Int64(0)
    var ptsRank = Int64(0)
    var ptsPG = 0.00
    var rebRank = Int64(0)
    var rebPG = 0.00
    var astRank = Int64(0)
    var astPG = 0.00
    var oppRank = Int64(0)
    var oppPg = 0.00
    
    init(info: NSArray, stats: NSArray) {
        
        self.city = info[2] as? String ?? ""
        self.name = info[3] as? String ?? ""
        self.threeLetter = info[4] as? String ?? ""
        self.conference = info[5] as? String ?? ""
        self.division = info[6] as? String ?? ""
        self.wins = info[8] as? Int64 ?? 0
        self.losses = info[9] as? Int64 ?? 0
        self.winPct = (info[10] as? Double)! * 100 
        self.confRank = info[11] as? Int64 ?? 0
        self.divRank = info[12] as? Int64 ?? 0
        self.ptsRank = stats[3] as? Int64 ?? 0
        self.ptsPG = stats[4] as? Double ?? 0.00
        self.rebRank = stats[5] as? Int64 ?? 0
        self.rebPG = stats[6] as? Double ?? 0.00
        self.astRank = stats[7] as? Int64 ?? 0
        self.astPG = stats[8] as? Double ?? 0.00
        self.oppRank = stats[9] as? Int64 ?? 0
        self.oppPg = stats[10] as? Double ?? 0.00
    }
}
