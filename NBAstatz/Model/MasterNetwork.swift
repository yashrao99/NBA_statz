//
//  MasterNetwork.swift
//  NBAstatz
//
//  Created by Yash Rao on 3/3/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import Firebase

class MasterNetwork: NSObject {
    
    override init() {
        super.init()
    }
    
    func buildURL(_ endPoint: String,_ parameters: [String:String]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.NBA_Py_Constants.scheme
        components.host = Constants.NBA_Py_Constants.host
        components.path = "/stats/\(endPoint)"
        components.queryItems = [URLQueryItem]()
        
        for (key,value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems?.append(queryItem)
        }
        return components.url!
    }
    
    func standardGETRequest(_ url: URL, completionHandlerForGETRequest: @escaping (_ success: Bool, _ result: [String:AnyObject]?, _ error: String?) -> Void) {
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 120
        let task = session.dataTask(with: request as URLRequest) {data, response, error in
            
            func displayError(_ error: String) {
                print(error)
            }
            
            guard (error == nil) else {
                displayError("There is an error with network request - \(error)")
                completionHandlerForGETRequest(false, nil, error as? String)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                completionHandlerForGETRequest(false, nil, error as? String)
                return
            }
            
            guard let data = data else {
                displayError("There was no data returned by the request!")
                completionHandlerForGETRequest(false, nil, error as? String)
                return
            }
            
            var parsedResult: [String:AnyObject]
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                completionHandlerForGETRequest(true, parsedResult, nil)
            } catch {
                displayError("Cannot display the data as JSON")
                return
            }
        }
        task.resume()
    }
    
    func parseRoster(_ parsedResult: [String:AnyObject], completionHandlerParse: @escaping (_ completeParse: Bool,_ playerInfoArray: [NSArray]) -> Void) {
        
        var infoStructArray: [NSArray] = []
        if let layerOne = parsedResult["resultSets"] as? NSArray {
            if let layerTwo = layerOne[0] as? [String:AnyObject] {
                if let finalLayer = layerTwo["rowSet"] as? [NSArray] {
                    for array in finalLayer {
                        infoStructArray.append(array)
                    }
                }
            }
        }
        completionHandlerParse(true, infoStructArray)
    }
    
    func parsePlayerStats(_ parsedResult: [String:AnyObject], _ infoStructArray : NSArray, completionHandlerPlayerStats: @escaping(_ completeParse: Bool, _ playerArray: [PlayerInformation]) -> Void) {
        
        var playerArray: [PlayerInformation] = []
        var currentSznStats: NSArray!
        var careerStats: NSArray!
        
        if let layerOne = parsedResult["resultSets"] as? NSArray {
            let layerTwo = layerOne[0] as? [String:AnyObject]
            let layerThree = layerTwo!["rowSet"] as? [NSArray]
            for array in layerThree! {
                if array[1] as! String  == "2017-18" {
                     currentSznStats = array
                }
            }
            let otherTwo = layerOne[1] as? [String:AnyObject]
            let otherThree = otherTwo!["rowSet"] as? [NSArray]
            for array in otherThree! {
                careerStats = array
            }
            
            if (infoStructArray[8] as? String) != "" {
                if currentSznStats != nil && careerStats != nil {
                    if (infoStructArray[0] as? Int) == (currentSznStats![0] as? Int) && (infoStructArray[0] as? Int)  == (careerStats![0] as? Int) {
                        playerArray.append(PlayerInformation(fromRoster: infoStructArray, fromCareer: careerStats, fromSeason: currentSznStats))
                    }
                }
            }
        }
        completionHandlerPlayerStats(true, playerArray)
    }
    
    func parseGame(_ parsedResult: [String:AnyObject], completionHandlerParse: @escaping (_ completeParse: Bool,_ gameArray: [GameStruct]) -> Void) {
        
        var gameArray : [GameStruct] = []
        if let layerOne = parsedResult["resultSets"] as? NSArray {
            let layerTwo = layerOne[1] as? [String:AnyObject]
            let layerThree = layerTwo!["rowSet"] as? [NSArray]
            let awayTeam = layerThree![0]
            let homeTeam = layerThree![1]
            gameArray.append(GameStruct(away: awayTeam, home: homeTeam))
        }
        completionHandlerParse(true, gameArray)
    }
    
    func parseTeam(_ parsedResult: [String:AnyObject], completionHandlerParse: @escaping (_ completeParse: Bool, _ teamArray: [TeamStruct]?) -> Void) {
        
        var teamArray : [TeamStruct] = []
        if let layerOne = parsedResult["resultSets"] as? NSArray {
            let layerTwo = layerOne[0] as? [String:AnyObject]
            let layerThree = layerTwo!["rowSet"] as? [NSArray]
            let info = layerThree![0]
            let otherLayerTwo = layerOne[1] as? [String:AnyObject]
            let otherLayerThree = otherLayerTwo!["rowSet"] as? [NSArray]
            let stats = otherLayerThree![0]
            teamArray.append(TeamStruct(info: info, stats: stats))
        }
        completionHandlerParse(true, teamArray)
    }

    class func sharedInstance() -> MasterNetwork {
        struct Singleton {
            static var sharedInstance = MasterNetwork()
        }
        return Singleton.sharedInstance
    }
}

