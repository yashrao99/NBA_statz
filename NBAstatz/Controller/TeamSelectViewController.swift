//
//  TeamSelectViewController.swift
//  NBAstatz
//
//  Created by Yash Rao on 6/6/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import UIKit

class TeamSelectViewController: UIViewController {
    
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func getImages() {
//
//        let fileManager = FileManager.default
//        let imagePath = Bundle.main.resourcePath! + "/teams.bundle"
//        imageNames = try! fileManager.contentsOfDirectory(atPath: imagePath)
//        imageNames.sort()
//        print(imageNames)
//
//        DispatchQueue.main.async {
//            self.teamCollectionView.reloadData()
//        }
//        print(imageNames[0])
//        test.image = UIImage(named: imageNames[0], in: Bundle(identifier: imagePath), compatibleWith: nil)
//    }
}

extension TeamSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        teamCollectionView.dataSource = self
        teamCollectionView.delegate = self
        teamCollectionView.allowsMultipleSelection = false
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.teamArray.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamCollectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCollectionCell

        cell.teamLogo.image = UIImage(named: Constants.teamArray.teams[indexPath.row])
        cell.teamLogo.contentMode = .scaleAspectFit
        return cell
    }
}



