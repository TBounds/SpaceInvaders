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
    let desiredWidthRatio : CGFloat = 5 // Percentage of screen width you want the enemies' width to take
    
    init(imageName: String) {
        
        let texture = SKTexture(imageNamed: ("images/" + imageName))
        let textureScale = (desiredWidthRatio/((100 * texture.size().width)/UIScreen.main.bounds.width))
        let newSize = CGSize(width: texture.size().width * textureScale, height: texture.size().height * textureScale)
        
        super.init(texture: texture, color: SKColor.clear, size: newSize)
        self.name = "invader"
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: newSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Invader
        self.physicsBody?.contactTestBitMask = CollisionCategories.PlayerBullet | CollisionCategories.Player
        self.physicsBody?.collisionBitMask = 0x0
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
