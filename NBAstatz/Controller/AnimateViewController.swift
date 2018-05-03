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

    var rosterArray : [Player] = []
    var teamArray : [Team] = []
    var rosterFetchController: NSFetchedResultsController<Player>!
    
    override func viewDidLoad() {
        configureUI()
        rosterArray = rosterFetch()!
        print(rosterArray.count)
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
                rosterArray.append(rosterFetchController.object(at: IndexPath(row: index, section: 0)))
            }
            return rosterArray
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
             let roster = MasterNetwork.sharedInstance().parseRoster(result!)
                for item in roster! {
                    if item.city != "" {
                        let player = Player(context: self.dataController.persistentContainer.viewContext)
                        player.city = item.city
                        player.name = item.name
                        player.personID = Int64(item.personID)
                        player.startYear = item.startYear
                        player.team = item.team
                        player.teamID = Int64(item.teamID)
                        player.threeLetter = item.teamThreeLetter
                        self.rosterArray.append(player)
                    }
                }
                try? self.dataController.persistentContainer.viewContext.save()
            }
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
                        let replaceTrack = self.createShapeLayer(UIColor.lightGray.cgColor, UIColor.black.cgColor, 20)
                        let replaceShape = self.createShapeLayer(Constants.Colors.celticsSecondary.cgColor, UIColor.clear.cgColor, 20)
                        replaceShape.strokeEnd = 0
                        self.view.layer.replaceSublayer(self.view.layer.sublayers![0], with: replacePulse)
                        self.view.layer.replaceSublayer(self.view.layer.sublayers![2], with: replaceShape)
                        self.animatePulsatingLayer(replacePulse)
                        self.animateCircle(replaceShape)
                    }
                    
                    let teams = MasterNetwork.sharedInstance().parseTeam(result!)
                    for item in teams {
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
                        self.teamArray.append(team)
                    }
                }
                try? self.dataController.viewContext.save()
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


