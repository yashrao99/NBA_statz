//
//  GameStruct.swift
//  NBAstatz
//
//  Created by Yash Rao on 5/8/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit

struct GameStruct {
    
    var awayTeamID = Int64(0)
    var awayTeam = ""
    var awayCity = ""
    var awayORebChance = Int64(0)
    var awayDRebChance = Int64(0)
    var awaySecondaryAst = Int64(0)
    var awayFTAst = Int64(0)
    var awayTotalPasses = Int64(0)
    var awayTotalAssist = Int64(0)
    var awayContestFGM = Int64(0)
    var awayContestFGA = Int64(0)
    var awayContestFGP = 0.00
    var awayUncontestFGM = Int64(0)
    var awayUncontestFGA = Int64(0)
    var awayUncontestFGP = 0.00
    var awayFGPct = 0.00
    var awayOppBadShotMade = Int64(0)
    var awayOppBadShotAttempt = Int64(0)
    var awayOppBadShotFGP = 0.00
    
    var homeTeamID = Int64(0)
    var homeTeam = ""
    var homeCity = ""
    var homeORebChance = Int64(0)
    var homeDRebChance = Int64(0)
    var homeSecondaryAst = Int64(0)
    var homeFTAst = Int64(0)
    var homeTotalPasses = Int64(0)
    var homeTotalAssist = Int64(0)
    var homeContestFGM = Int64(0)
    var homeContestFGA = Int64(0)
    var homeContestFGP = 0.00
    var homeUncontestFGM = Int64(0)
    var homeUncontestFGA = Int64(0)
    var homeUncontestFGP = 0.00
    var homeFGPct = 0.00
    var homeOppBadShotMade = Int64(0)
    var homeOppBadShotAttempt = Int64(0)
    var homeOppBadShotFGP = 0.00
    
    init(away: NSArray, home: NSArray) {
        
        self.awayTeamID = away[1] as? Int64 ?? 0
        self.awayTeam = away[2] as? String ?? ""
        self.awayCity = away[4] as? String ?? ""
        self.awayORebChance = away[7] as? Int64 ?? 0
        self.awayDRebChance = away[8] as? Int64 ?? 0
        self.awaySecondaryAst = away[11] as? Int64 ?? 0
        self.awayFTAst = away[12] as? Int64 ?? 0
        self.awayTotalPasses = away[13] as? Int64 ?? 0
        self.awayTotalAssist = away[14] as? Int64 ?? 0
        self.awayContestFGM = away[15] as? Int64 ?? 0
        self.awayContestFGA = away[16] as? Int64 ?? 0
        self.awayContestFGP = away[17] as? Double ?? 0.00
        self.awayUncontestFGM = away[18] as? Int64 ?? 0
        self.awayUncontestFGA = away[19] as? Int64 ?? 0
        self.awayUncontestFGP = away[20] as? Double ?? 0.00
        self.awayFGPct = away[21] as? Double ?? 0.00
        self.awayOppBadShotMade = away[22] as? Int64 ?? 0
        self.awayOppBadShotAttempt = away[23] as? Int64 ?? 0
        self.awayOppBadShotFGP = away[24] as? Double ?? 0.00
        
        self.homeTeamID = home[1] as? Int64 ?? 0
        self.homeTeam = home[2] as? String ?? ""
        self.homeCity = home[4] as? String ?? ""
        self.homeORebChance = home[7] as? Int64 ?? 0
        self.homeDRebChance = home[8] as? Int64 ?? 0
        self.homeSecondaryAst = home[11] as? Int64 ?? 0
        self.homeFTAst = home[12] as? Int64 ?? 0
        self.homeTotalPasses = home[13] as? Int64 ?? 0
        self.homeTotalAssist = home[14] as? Int64 ?? 0
        self.homeContestFGM = home[15] as? Int64 ?? 0
        self.homeContestFGA = home[16] as? Int64 ?? 0
        self.homeContestFGP = home[17] as? Double ?? 0.00
        self.homeUncontestFGM = home[18] as? Int64 ?? 0
        self.homeUncontestFGA = home[19] as? Int64 ?? 0
        self.homeUncontestFGP = home[20] as? Double ?? 0.00
        self.homeFGPct = home[21] as? Double ?? 0.00
        self.homeOppBadShotMade = home[22] as? Int64 ?? 0
        self.homeOppBadShotAttempt = home[23] as? Int64 ?? 0
        self.homeOppBadShotFGP = home[24] as? Double ?? 0.00
    }
    
    
}
