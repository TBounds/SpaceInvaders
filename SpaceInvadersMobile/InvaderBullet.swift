//
//  InvaderBullet.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class InvaderBullet: Bullet {
    
    override init(imageName: String, bulletSound:String?){
        
        super.init(imageName: imageName, bulletSound: bulletSound)
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size) // Possibly change this to reduce computations 'init(rectangleOfSize:)'
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategories.InvaderBullet
        self.physicsBody?.contactTestBitMask = CollisionCategories.Player
        self.physicsBody?.collisionBitMask = 0x0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
