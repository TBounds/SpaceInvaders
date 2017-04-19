//
//  PulsatingText.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/13/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class PulsatingText : SKLabelNode {
    
    func setTextFontSizeAndPulsate(theText: String, theFontSize: CGFloat){
        
        self.text = theText;
        self.fontSize = theFontSize
        
        let scaleSequence = SKAction.sequence([SKAction.scale(to: 1.5, duration: 1),SKAction.scale(to: 1.0, duration:1)])
        let scaleForever = SKAction.repeatForever(scaleSequence)
        
        self.run(scaleForever)
    }
}
