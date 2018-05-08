//
//  AnimateViewController.swift
//  NBAstatz
//
//  Created by Yash Rao on 4/30/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AnimateViewController: UIViewController, NSFetchedResultsControllerDelegate{
    
    var dataController: DataController!
    var shapeLayer : CAShapeLayer!
    var pulsatingLayer : CAShapeLayer!
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Initializing Data"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()

    var savedPlayerArray : [Player] = []
    var savedTeamsArray : [Team] = []
    var rosterFetchController: NSFetchedResultsController<Player>!
    
    override func viewDidLoad() {
        configureUI()
        downloadEverything()
    }
    
    fileprivate func createShapeLayer(_ strokeColor: CGColor,_ fillColor: CGColor,_ lineWidth: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor
        layer.fillColor = fillColor
        layer.lineCap = kCALineCapRound
        layer.position = view.center
        layer.lineWidth = lineWidth
        return layer
    }
    
    
    fileprivate func animateCircle(_ layer: CAShapeLayer) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        layer.add(basicAnimation, forKey: "test")
    }
    
    fileprivate func animatePulsatingLayer(_ layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: "pulsing")
    }
    
    func configureUI() {
        
        view.backgroundColor = UIColor.black
        
        pulsatingLayer = createShapeLayer(UIColor.clear.cgColor, Constants.Colors.lakersPrimary.cgColor, 10)
        view.layer.addSublayer(pulsatingLayer)
        
        let trackLayer = createShapeLayer(UIColor.lightGray.cgColor, UIColor.black.cgColor, 20)
        view.layer.addSublayer(trackLayer)
        
        animatePulsatingLayer(pulsatingLayer)
        
        shapeLayer = createShapeLayer(Constants.Colors.lakersSecondary.cgColor, UIColor.clear.cgColor, 20)
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        label.center = view.center
        
    }
    
    private func rosterFetch() -> [Player]? {
        let rosterRequest: NSFetchRequest<Player> = Player.fetchRequest()
        rosterRequest.sortDescriptors = []
        
        rosterFetchController = NSFetchedResultsController(fetchRequest: rosterRequest, managedObjectContext: dataController.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        rosterFetchController.delegate = self
        
        do {
            try rosterFetchController.performFetch()
        } catch {
            fatalError("Fetch cannot be completed: \(error.localizedDescription)")
        }
        
        do {
            let rosterCount = try rosterFetchController.managedObjectContext.count(for: rosterRequest)
            for index in 0..<rosterCount {
                savedPlayerArray.append(rosterFetchController.object(at: IndexPath(row: index, section: 0)))
            }
            return savedPlayerArray
        } catch {
            return nil
        }
    }
    
    private func downloadRosterInformation(completionHandlerRoster: @escaping (_ success: Bool) -> Void) {
        let rosterUrl = MasterNetwork.sharedInstance().buildURL("commonallplayers", ["LeagueID":"00", "Season":"2017-18", "IsOnlyCurrentSeason": "1"])
        MasterNetwork.sharedInstance().standardGETRequest(rosterUrl) { success, result, error in
            
            if success {
                DispatchQueue.main.async {
                    self.shapeLayer.strokeEnd = 0
                    self.animateCircle(self.shapeLayer)
                }
                
                MasterNetwork.sharedInstance().parseRoster(result!) { completeParse, infoStructArray in
                    if completeParse {
                        for playerInfo in infoStructArray {
                            let playerStatURL = MasterNetwork.sharedInstance().buildURL("playercareerstats", ["PerMode":"Totals", "PlayerID":"\(playerInfo[0])"])
                            MasterNetwork.sharedInstance().standardGETRequest(playerStatURL) { success, result, error in
                                if success {
                                    MasterNetwork.sharedInstance().parsePlayerStats(result!, playerInfo) { completeParse, playerArray in
                                        if completeParse {
                                            for structPlayer in playerArray {
                                                let player = Player(context: self.dataController.persistentContainer.viewContext)
                                                player.age = structPlayer.age
                                                player.careerAst = structPlayer.careerAst
                                                player.careerBlk = structPlayer.careerBlk
                                                player.careerDReb = structPlayer.careerDReb
                                                player.careerFGA = structPlayer.careerFGA
                                                player.careerFGM = structPlayer.careerFGM
                                                player.careerFgPercent = structPlayer.careerFgPercent
                                                player.careerFouls = structPlayer.careerFouls
                                                player.careerFreeThrowPercent = structPlayer.careerFreeThrowPercent
                                                player.careerftAttempt = structPlayer.careerftAttempt
                                                player.careerftMade = structPlayer.careerftMade
                                                player.careerGamesPlayed = structPlayer.careerGamesPlayed
                                                player.careerGamesStarted = structPlayer.careerGamesStarted
                                                player.careerMinutes = structPlayer.careerMinutes
                                                player.careerOReb = structPlayer.careerOReb
                                                player.careerPoints = structPlayer.careerPoints
                                                player.careerStl = structPlayer.careerStl
                                                player.careerThreeAttempt = structPlayer.careerThreeAttempt
                                                player.careerThreeFgPercent = structPlayer.careerThreeFgPercent
                                                player.careerThreeMade = structPlayer.careerThreeMade
                                                player.careerTO = structPlayer.careerTO
                                                player.careerTotalReb = structPlayer.careerTotalReb
                                                player.city = structPlayer.city
                                                player.currentAst = structPlayer.currentAst
                                                player.currentBlk = structPlayer.currentBlk
                                                player.currentDReb = structPlayer.currentDReb
                                                player.currentFGA = structPlayer.currentFGA
                                                player.currentFGM = structPlayer.currentFGM
                                                player.currentFgPercent = structPlayer.currentFgPercent
                                                player.currentFouls = structPlayer.currentFouls
                                                player.currentFreeThrowPercent = structPlayer.currentFreeThrowPercent
                                                player.currentGamesPlayed = structPlayer.currentGamesPlayed
                                                player.currentGamesStarted = structPlayer.currentGamesStarted
                                                player.currentOReb = structPlayer.currentOReb
                                                player.currentPoints = structPlayer.currentPoints
                                                player.currentStl = structPlayer.currentStl
                                                player.currentSznMins = structPlayer.currentSznMins
                                                player.currentThreeAttempt = structPlayer.currentThreeAttempt
                                                player.currentThreeFgPercent = structPlayer.currentThreeFgPercent
                                                player.currentThreeMade = structPlayer.currentThreeMade
                                                player.currentTO = structPlayer.currentTO
                                                player.currentTotalReb = structPlayer.currentTotalReb
                                                player.ftAttempt = structPlayer.ftAttempt
                                                player.ftMade = structPlayer.ftMade
                                                player.name = structPlayer.name
                                                player.personID = structPlayer.personID
                                                player.startYear = structPlayer.startYear
                                                player.team = structPlayer.team
                                                player.teamID = structPlayer.teamID
                                                player.threeLetter = structPlayer.teamThreeLetter
                                                self.savedPlayerArray.append(player)
                                            }
                                        }
                                        print(self.savedPlayerArray.count)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            try? self.dataController.persistentContainer.viewContext.save()
        }
        completionHandlerRoster(true)
    }
    
    private func downloadTeamInfo(completionHandlerTeam: @escaping (_ success: Bool) -> Void) {
        for ID in Constants.TeamID.AllTeams {
            let teamUrl = MasterNetwork.sharedInstance().buildURL("teaminfocommon", ["LeagueID":"00", "Season":"2017-18", "TeamID": "\(ID)"])
            
            MasterNetwork.sharedInstance().standardGETRequest(teamUrl) {success, result, error in
                if success {
                    DispatchQueue.main.async {
                        self.changeLabel(self.label, "Saving Teams", 20, UIColor.white)
                        let replacePulse = self.createShapeLayer(UIColor.clear.cgColor, Constants.Colors.celticsPrimary.cgColor, 10)
                        //let replaceTrack = self.createShapeLayer(UIColor.lightGray.cgColor, UIColor.black.cgColor, 20)
                        let replaceShape = self.createShapeLayer(Constants.Colors.celticsSecondary.cgColor, UIColor.clear.cgColor, 20)
                        replaceShape.strokeEnd = 0
                        self.view.layer.replaceSublayer(self.view.layer.sublayers![0], with: replacePulse)
                        self.view.layer.replaceSublayer(self.view.layer.sublayers![2], with: replaceShape)
                        self.animatePulsatingLayer(replacePulse)
                        self.animateCircle(replaceShape)
                    }
                    
                    MasterNetwork.sharedInstance().parseTeam(result!) { completeParse, teamArray in
                        if completeParse {
                            for item in teamArray! {
                                let team = Team(context: self.dataController.persistentContainer.viewContext)
                                team.astPG = item.astPG
                                team.astRank = item.astRank
                                team.city = item.city
                                team.conference = item.conference
                                team.confRank = item.confRank
                                team.division = item.division
                                team.divRank = item.divRank
                                team.losses = item.losses
                                team.name = item.name
                                team.oppPg = item.oppPg
                                team.oppRank = item.oppRank
                                team.ptsPG = item.ptsPG
                                team.ptsRank = item.ptsRank
                                team.rebPG = item.rebPG
                                team.rebRank = item.rebRank
                                team.threeLetter = item.threeLetter
                                team.winPct = item.winPct
                                team.wins = item.wins
                                self.savedTeamsArray.append(team)
                            }
                        }
                        print(self.savedTeamsArray.count)
                    }
                }
                try? self.dataController.persistentContainer.viewContext.save()
            }
        }
        completionHandlerTeam(true)
    }
    
    private func downloadEverything() {
        
        downloadRosterInformation() { success in
            if success {
                self.downloadTeamInfo() { success in
                    if success {
                        print("YEE")
                    }
                }
            }
        }
        
    }
    
    func changeLabel(_ label: UILabel,_ text: String, _ size: CGFloat, _ color: UIColor) {
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.textColor = color
    }
}


