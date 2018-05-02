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
    
    
    func getRoster(_ url: URL, completionHandlerForRoster: @escaping (_ success: Bool,_ result: [PlayerInformation]?,_ error: String?) -> Void) {
        
        var players : [PlayerInformation] = []
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {data, response, error in
            
            
            func displayError(_ error: String) {
                print(error)
            }
            
            guard (error == nil) else {
                displayError("There is an error with network request - \(error)")
                completionHandlerForRoster(false, nil, error as? String)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                completionHandlerForRoster(false, nil, error as? String)
                return
            }
            
            guard let data = data else {
                displayError("There was no data returned by the request!")
                completionHandlerForRoster(false, nil, error as? String)
                return
            }
            
            var parsedResult: [String:AnyObject]
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                displayError("Cannot display the data as JSON")
                return
            }
            
            if let layerOne = parsedResult["resultSets"] as? NSArray {
                if let layerTwo = layerOne[0] as? [String:AnyObject] {
                    if let finalLayer = layerTwo["rowSet"] as? [NSArray] {
                        for array in finalLayer {
                            players.append(PlayerInformation(array: array))
                            
                        }
                    }
                }
            }
            completionHandlerForRoster(true, players , nil)
        }
        task.resume()
        
    }

    class func sharedInstance() -> MasterNetwork {
        struct Singleton {
            static var sharedInstance = MasterNetwork()
        }
        return Singleton.sharedInstance
    }
}

