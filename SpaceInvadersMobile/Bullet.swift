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
    
    let desiredWidthRatio = CGFloat(1) // Percentage of screen width you want the bullets width to take. 
    
    init(imageName: String, bulletSound: String?) {
        
        let texture = SKTexture(imageNamed: imageName)
        
        let textureScale = (desiredWidthRatio/((100 * texture.size().width)/UIScreen.main.bounds.width))
        let newSize = CGSize(width: texture.size().width * textureScale, height: texture.size().height * textureScale)
        
        super.init(texture: texture, color: SKColor.clear, size: newSize)
        
        if(bulletSound != nil){
            run(SKAction.playSoundFileNamed(bulletSound!, waitForCompletion: false))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
