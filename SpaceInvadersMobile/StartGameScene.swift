//
//  StartGameScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let startGameButton = SKSpriteNode(imageNamed: "images/newgamebtn.png")
        startGameButton.position = CGPoint(x: size.width/2, y: size.height/2)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        let invaderText = PulsatingText(fontNamed: "ChalkDuster")
        invaderText.setTextFontSizeAndPulsate(theText: "INVADERZ", theFontSize: 50)
        invaderText.position = CGPoint(x: size.width/2, y: size.height/2 + 200)
        addChild(invaderText)
        
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField?.zPosition = -1000
        starField?.position = CGPoint(x: size.width/2, y: size.height)
        starField?.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        addChild(starField!)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first as UITouch!
        let touchLocation = touch?.location(in: self)
        let touchedNode = self.atPoint(touchLocation!)
        
        if touchedNode.name == "startgame" {
            
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipHorizontal(withDuration: 1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
        
    }
}
