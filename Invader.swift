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
    
    func fireBullet(scene: SKScene) {
    
    }
    
}
