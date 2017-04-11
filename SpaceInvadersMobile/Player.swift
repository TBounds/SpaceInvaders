//
//  Player.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {

    init() {
        let texture = SKTexture(imageNamed: "images/player1")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animate() {
        var playerTextures: [SKTexture] = []
        
        for i in 1...2 {
            playerTextures.append(SKTexture(imageNamed: "images/player\(i)"))
        }
        
        let playerAnimation = SKAction.repeatForever(SKAction.animate(with: playerTextures, timePerFrame: 0.1))
        self.run(playerAnimation)
        
    }
    
    func die() {
        
    }
    
    func kill() {
        
    }
    
    func respawn() {
        
    }
    
    func fireBullet(scene: SKScene) {
        
    }
}
