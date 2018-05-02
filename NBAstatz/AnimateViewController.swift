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
    let shapeLayer = CAShapeLayer()
    let label: UILabel = {
        let label = UILabel()
        label.text = "Initializing Data"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    let rosterUrl = MasterNetwork.sharedInstance().buildURL("commonallplayers", ["LeagueID":"00", "Season":"2017-18", "IsOnlyCurrentSeason": "1"])
    var rosterArray : [Player] = []
    var rosterFetchController: NSFetchedResultsController<Player>!
    
    override func viewDidLoad() {
        configureUI()
        rosterFetch()
        if rosterArray.count == 0 {
         downloadRosterInformation()
        }
    }
    
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 4
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "test")
    }
    
    func configureUI() {
        
        let center = view.center
        
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
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
    
    private func downloadRosterInformation() {
        MasterNetwork.sharedInstance().getRoster(rosterUrl) { success, result, error in
            if success {
                
                DispatchQueue.main.async {
                    self.animateCircle()
                }
                for item in result! {
                    print(item)
                    let player = Player(context: self.dataController.persistentContainer.viewContext)
                    player.city = item.city
                    player.name = item.name
                    //player.personID = Int64(item.personID)
                    player.startYear = item.startYear
                    player.team = item.team
                    //player.teamID = Int64(item.teamID)
                    player.threeLetter = item.teamThreeLetter
                    self.rosterArray.append(player)
                    try? self.dataController.persistentContainer.viewContext.save()
                }
                print(self.rosterArray)
            }
        }
    }
    
    func changeLabel(_ label: UILabel,_ text: String, _ size: CGFloat) {
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: size)
    }

}

//extension AnimateViewController : URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("Finished downloading")
//    }
//
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
//        print(CGFloat(totalBytesWritten))
//        print(CGFloat(totalBytesExpectedToWrite))
//        print(percentage)
//        print("Animate  one is calleD")
//
//        DispatchQueue.main.async {
//            self.shapeLayer.strokeEnd = percentage
//        }
//    }
//
//
//    func monitorDownload(_ url: URL) {
//
//        let configuration = URLSessionConfiguration.default
//        let operationQueue = OperationQueue()
//        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
//        let downloadTask = urlSession.downloadTask(with: url)
//        downloadTask.resume()
//
//    }
//}

