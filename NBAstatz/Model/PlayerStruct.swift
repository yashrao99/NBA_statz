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
    
    // Attributes from parseRoster
    
    var personID = Int64(0)
    var name = ""
    var startYear = ""
    var teamID = Int64(0)
    var city = ""
    var team = ""
    var teamThreeLetter = ""
    
    // Attributes from currentSeason (parsePlayerStats)
    
    var age = Int64(0)
    var currentGamesPlayed = Int64(0)
    var currentGamesStarted = Int64(0)
    var currentSznMins = Int64(0)
    var currentFGM = Int64(0)
    var currentFGA = Int64(0)
    var currentFgPercent = 0.00
    var currentThreeMade = Int64(0)
    var currentThreeAttempt = Int64(0)
    var currentThreeFgPercent = 0.00
    var ftMade = Int64(0)
    var ftAttempt = Int64(0)
    var currentFreeThrowPercent = 0.00
    var currentOReb = Int64(0)
    var currentDReb = Int64(0)
    var currentTotalReb = Int64(0)
    var currentAst = Int64(0)
    var currentStl = Int64(0)
    var currentBlk = Int64(0)
    var currentTO = Int64(0)
    var currentFouls = Int64(0)
    var currentPoints = Int64(0)
    
    // Attributes from careerStats (parsePlayerStats)
    
    var careerGamesPlayed = Int64(0)
    var careerGamesStarted = Int64(0)
    var careerMinutes = Int64(0)
    var careerFGM = Int64(0)
    var careerFGA = Int64(0)
    var careerFgPercent = 0.00
    var careerThreeMade = Int64(0)
    var careerThreeAttempt = Int64(0)
    var careerThreeFgPercent = 0.00
    var careerftMade = Int64(0)
    var careerftAttempt = Int64(0)
    var careerFreeThrowPercent = 0.00
    var careerOReb = Int64(0)
    var careerDReb = Int64(0)
    var careerTotalReb = Int64(0)
    var careerAst = Int64(0)
    var careerStl = Int64(0)
    var careerBlk = Int64(0)
    var careerTO = Int64(0)
    var careerFouls = Int64(0)
    var careerPoints = Int64(0)
    
    
    
    init(fromRoster: NSArray, fromCareer: NSArray, fromSeason: NSArray) {
        
        // Attributes from parseRoster
        
        self.personID = (fromRoster[0] as? Int64)!
        self.name = (fromRoster[2] as? String)!
        self.startYear = (fromRoster[4] as? String)!
        self.teamID = (fromRoster[7] as? Int64)!
        self.city = (fromRoster[8] as? String)!
        self.team = (fromRoster[9] as? String)!
        self.teamThreeLetter = (fromRoster[10] as? String)!
        
        //Attributes from currentSeason (parsePlayerStats)
        
        self.age = fromSeason[5] as? Int64 ?? 0
        self.currentGamesPlayed = fromSeason[6] as? Int64 ?? 0
        self.currentGamesStarted = fromSeason[7] as? Int64 ?? 0
        self.currentSznMins = fromSeason[8] as? Int64 ?? 0
        self.currentFGM = fromSeason[9] as? Int64 ?? 0
        self.currentFGA = fromSeason[10] as? Int64 ?? 0
        self.currentFgPercent = fromSeason[11] as? Double ?? 0.00
        self.currentThreeMade = fromSeason[12] as? Int64 ?? 0
        self.currentThreeAttempt = fromSeason[13] as? Int64 ?? 0
        self.currentThreeFgPercent = fromSeason[14] as? Double ?? 0.00
        self.ftMade = fromSeason[15] as? Int64 ?? 0
        self.ftAttempt = fromSeason[16] as? Int64 ?? 0
        self.currentFreeThrowPercent = fromSeason[17] as? Double ?? 0.00
        self.currentOReb = fromSeason[18] as? Int64 ?? 0
        self.currentDReb = fromSeason[19] as? Int64 ?? 0
        self.currentTotalReb = fromSeason[20] as? Int64 ?? 0
        self.currentAst = fromSeason[21] as? Int64 ?? 0
        self.currentStl = fromSeason[22] as? Int64 ?? 0
        self.currentBlk = fromSeason[23] as? Int64 ?? 0
        self.currentTO = fromSeason[24] as? Int64 ?? 0
        self.currentFouls = fromSeason[25] as? Int64 ?? 0
        self.currentPoints = fromSeason[26] as? Int64 ?? 0
        
        // Attributes from careerStats (parsePlayerStats)
        
        self.careerGamesPlayed = fromCareer[3] as? Int64 ?? 0
        self.careerGamesStarted = fromCareer[4] as? Int64 ?? 0
        self.careerMinutes = fromCareer[5] as? Int64 ?? 0
        self.careerFGM = fromCareer[6] as? Int64 ?? 0
        self.careerFGA = fromCareer[7] as? Int64 ?? 0
        self.careerFgPercent = fromCareer[8] as? Double ?? 0.00
        self.careerThreeMade = fromCareer[9] as? Int64 ?? 0
        self.careerThreeAttempt = fromCareer[10] as? Int64 ?? 0
        self.careerThreeFgPercent = fromCareer[11] as? Double ?? 0.00
        self.careerftMade = fromCareer[12] as? Int64 ?? 0
        self.careerftAttempt = fromCareer[13] as? Int64 ?? 0
        self.careerFreeThrowPercent = fromCareer[14] as? Double ?? 0.00
        self.careerOReb = fromCareer[15] as? Int64 ?? 0
        self.careerDReb = fromCareer[16] as? Int64 ?? 0
        self.careerTotalReb = fromCareer[17] as? Int64 ?? 0
        self.careerAst = fromCareer[18] as? Int64 ?? 0
        self.careerStl = fromCareer[19] as? Int64 ?? 0
        self.careerBlk = fromCareer[20] as? Int64 ?? 0
        self.careerTO = fromCareer[21] as? Int64 ?? 0
        self.careerFouls = fromCareer[22] as? Int64 ?? 0
        self.careerPoints = fromCareer[23] as? Int64 ?? 0
    }
}
