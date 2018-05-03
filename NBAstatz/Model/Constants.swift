//
//  Constants.swift
//  NBAstatz
//
//  Created by Yash Rao on 4/27/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    
    struct NBA_Py_Constants {
        static let scheme = "http"
        static let host = "stats.nba.com"
        static let path = "/stats/"
        
    }
    
    struct Colors {
        static let lakersPrimary = UIColor.rgb(r: 84, g: 37, b: 131)
        static let lakersSecondary = UIColor.rgb(r: 253, g: 184, b: 39)
        static let celticsPrimary = UIColor.rgb(r: 0, g: 136, b: 83)
        static let celticsSecondary = UIColor.rgb(r: 188, g: 154, b: 92)
    }
    
    struct TeamID {
        //Weird ones are Sixers and TrailBlazers(76ers and Trail Blazers in the struct")
        static let Hawks = 1610612737
        static let Celtics = 1610612738
        static let Nets = 1610612751
        static let Hornets = 1610612766
        static let Bulls = 1610612741
        static let Cavaliers = 1610612739
        static let Mavericks = 1610612742
        static let Nuggets = 1610612743
        static let Pistons = 1610612765
        static let Warriors = 1610612744
        static let Rockets = 1610612745
        static let Pacers = 1610612754
        static let Clippers = 1610612746
        static let Lakers = 1610612747
        static let Grizzlies = 1610612763
        static let Heat = 1610612748
        static let Bucks = 1610612749
        static let Timberwolves = 1610612750
        static let Pelicans = 1610612740
        static let Knicks = 1610612752
        static let Thunder = 1610612760
        static let Magic = 1610612753
        static let Sixers = 1610612755
        static let Suns = 1610612756
        static let Trailblazers = 1610612757
        static let Kings = 1610612758
        static let Spurs = 1610612759
        static let Raptors = 1610612761
        static let Jazz = 1610612762
        static let Wizards = 1610612764
        
        static let AllTeams = [TeamID.Bucks, TeamID.Bucks, TeamID.Cavaliers, TeamID.Celtics, TeamID.Clippers, TeamID.Grizzlies, TeamID.Hawks, TeamID.Heat, TeamID.Hornets, TeamID.Jazz, TeamID.Kings, TeamID.Knicks, TeamID.Lakers, TeamID.Magic, TeamID.Mavericks, TeamID.Nets, TeamID.Nuggets, TeamID.Pacers, TeamID.Pelicans, TeamID.Pistons, TeamID.Raptors, TeamID.Rockets, TeamID.Sixers, TeamID.Spurs, TeamID.Suns, TeamID.Thunder, TeamID.Timberwolves, TeamID.Trailblazers, TeamID.Warriors, TeamID.Wizards]
    }
    
    
    
    
    
}

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
