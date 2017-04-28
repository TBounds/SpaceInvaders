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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let desiredWidthRatio : CGFloat = 50 // Percentage of screen width you want the button width to take
    let pulsatingTextScaler = CGFloat(0.9)
    
    override func didMove(to view: SKView) {
        
        let startGameButton = SKSpriteNode(imageNamed: "newgame_button.png")
        let textureScale = (desiredWidthRatio/((100 * startGameButton.size.width)/UIScreen.main.bounds.width))
        let newSize = CGSize(width: startGameButton.size.width * textureScale, height: startGameButton.size.height * textureScale)
        
        startGameButton.size = newSize
        startGameButton.position = CGPoint(x: size.width/2,
                                           y: (size.height/4))
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        let highscoreButton = SKSpriteNode(imageNamed: "highscores_button.png")
        highscoreButton.size = newSize
        highscoreButton.position = CGPoint(x: size.width/2,
                                           y: startGameButton.position.y - (highscoreButton.size.height * 1.5))
        highscoreButton.name = "highscore"
        addChild(highscoreButton)
        
        
        let invaderText = PulsatingText(fontNamed: "ChalkDuster")
        invaderText.setTextFontSizeAndPulsate(theText: "INVADERZ", theFontSize: CGFloat((UIScreen.main.bounds.width/10) * pulsatingTextScaler))
        invaderText.position = CGPoint(x: size.width/2, y: size.height - invaderText.fontSize * 4)
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
            
            appDelegate.score = 0
            appDelegate.won = false
            
            let gameScene = GameScene(size: size)
            gameScene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipHorizontal(withDuration: 1.0)
            view?.presentScene(gameScene, transition: transitionType)
        }
        else if touchedNode.name == "highscore" {
            
            NSLog("Display highscores.")
            
            let highscoreScene = HighscoreScene(size: size)
            // let highscoreScene = GameOverScene(size: size)
            highscoreScene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipHorizontal(withDuration: 1.0)
            view?.presentScene(highscoreScene, transition: transitionType)
            
            
        }
        
    }
}
