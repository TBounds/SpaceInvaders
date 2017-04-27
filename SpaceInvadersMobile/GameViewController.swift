//
//  GameViewController.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit
// import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        
        let scene = StartGameScene(size: view.bounds.size)
        let skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
//        let ac = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
//        ac.addTextField(configurationHandler: nil)
//        
//        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
//            let playerName = ac.textFields![0]
//            
//        })
//        
//        self.present(ac, animated: true, completion: nil)
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
   
}
