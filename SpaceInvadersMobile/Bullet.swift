//
//  Bullet.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class Bullet: SKSpriteNode {
    
    init(imageName: String, bulletSound: String?) {
        
        let texture = SKTexture(imageNamed: imageName)
        
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        
        if(bulletSound != nil){
            run(SKAction.playSoundFileNamed(bulletSound!, waitForCompletion: false))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
