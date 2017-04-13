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
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
   
}
