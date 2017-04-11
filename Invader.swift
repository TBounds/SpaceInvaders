//
//  Invader.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class Invader: SKSpriteNode {

    var invaderRow = 0
    var invaderCol = 0
    
    init() {
        let texture = SKTexture(imageNamed: "images/invader1.png")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.name = "invader"
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func fireBullet(scene: SKScene){
        let bullet = InvaderBullet(imageName: "images/laser.png", bulletSound: nil)
        bullet.position.x = self.position.x
        bullet.position.y = self.position.y - self.size.height/2
        scene.addChild(bullet)
        let moveBulletAction = SKAction.move(to: CGPoint(x:self.position.x,y: 0 - bullet.size.height), duration: 2.0)
        let removeBulletAction = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([moveBulletAction,removeBulletAction]))
    }
    
}
