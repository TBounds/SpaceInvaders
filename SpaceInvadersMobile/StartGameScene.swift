//
//  StartGameScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let startGameButton = SKSpriteNode(imageNamed: "images/newgamebtn.png")
        startGameButton.position = CGPoint(x: size.width/2, y: size.height/2)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
    }
    
}
