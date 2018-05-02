//
//  HomeController.swift
//  NBAstatz
//
//  Created by Yash Rao on 3/1/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import Firebase
import CoreData

class HomeViewController: UIViewController, AuthUIDelegate, UINavigationControllerDelegate, FUIAuthDelegate, NSFetchedResultsControllerDelegate {

    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    var user: User?
    var displayName: String? = ""
    var ref: DatabaseReference!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var dataController: DataController!
    var players: [Player] = []
    var fetchedResultsController: NSFetchedResultsController<Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuth()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureAuth() {
        
        let provider: [FUIAuthProvider] = [FUIGoogleAuth()]
        FUIAuth.defaultAuthUI()?.providers = provider

        _authHandle = Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) in
            
            if let activeUser = user {
                if self.user != activeUser {
                    self.user = activeUser
                    let name = user!.email!.components(separatedBy: "@")[0]
                    self.displayName = name
                    
                }
            } else {
                self.loginSession()
            }
        }
    }
    
    func configureDatabase() {
        ref = Database.database().reference()
    }
    
    func configureStorage() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
    }
    
    func loginSession() {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self as FUIAuthDelegate
        let authViewController = CustomAuthViewController(authUI: authUI!)
        let navc = UINavigationController(rootViewController: authViewController)
        self.present(navc, animated: true, completion: nil)

    }
    
//    func frContrllerPlayers() -> [Player]? {
//        
//        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
//        fetchRequest.sortDescriptors = []
//        
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        fetchedResultsController.delegate = self
//    }
}
