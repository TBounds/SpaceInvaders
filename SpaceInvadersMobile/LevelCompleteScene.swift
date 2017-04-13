//
//  LevelCompleteScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/13/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import Foundation
import SpriteKit

class LevelCompleteScene:SKScene{
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black
        
        let startGameButton = SKSpriteNode(imageNamed: "images/nextlevelbtn")
        startGameButton.position = CGPoint(x: size.width/2, y: size.height/2 - 100)
        startGameButton.name = "nextlevel"
        addChild(startGameButton)
        
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField?.zPosition = -1000
        starField?.position = CGPoint(x: size.width/2, y: size.height)
        starField?.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        addChild(starField!)
        
        let invaderText = PulsatingText(fontNamed: "ChalkDuster")
        invaderText.setTextFontSizeAndPulsate(theText: "LEVEL COMPLETE", theFontSize: 50)
        invaderText.position = CGPoint(x: size.width/2, y: size.height/2 + 200)
        addChild(invaderText)
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        if(touchedNode.name == "nextlevel") {
            
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
            view?.presentScene(gameOverScene,transition: transitionType)
        }
    }
    
        
}
