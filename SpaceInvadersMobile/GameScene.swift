//
//  GameScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import SpriteKit
import GameplayKit

var invaderNum = 1

class GameScene: SKScene {
    
    // Invader Variables
    let rowsOfInvaders = 4
    var invaderSpeed = 2
    let leftBounds = CGFloat(30)
    var rightBounds = CGFloat(0)
    var invadersWhoCanFire: [Invader] = []
    
    // Player Variables
    var player : Player = Player()
    
    

    
    override func didMove(to view: SKView) {
        setupInvaders()
        setupPlayer()
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
//    }
    
//    override func update(currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//    }
    
    func setupInvaders() {
        var invaderRow = 0
        var invaderCol = 0
        let numberOfInvaders = invaderNum * 2 + 1
        
        for i in 1...rowsOfInvaders {
            invaderRow = i
            
            for j in 1...numberOfInvaders {
                invaderCol = j
                let tempInvader: Invader = Invader()
                let invaderHalfWidth: CGFloat = tempInvader.size.width/2
                let xPositionStart: CGFloat = size.width/2 - invaderHalfWidth - (CGFloat(invaderNum) * tempInvader.size.width) + CGFloat(10)
                tempInvader.position = CGPoint(x:xPositionStart + ((tempInvader.size.width+CGFloat(10))*(CGFloat(j-1))), y:CGFloat(self.size.height - CGFloat(i) * 46))
                tempInvader.invaderRow = invaderRow
                tempInvader.invaderCol = invaderCol
                addChild(tempInvader)
                
                if i == rowsOfInvaders {
                    invadersWhoCanFire.append(tempInvader)
                }
            }
        }
    }
    
    func setupPlayer() {
        player.position = CGPoint(x: self.frame.midX, y: player.size.height/2 + 10)
        addChild(player)
    }
    
    
    
}
