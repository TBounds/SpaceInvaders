//
//  HighscoreScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/26/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class HighscoreScene: SKScene {
        
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let desiredWidthRatio : CGFloat = 50 // Percentage of screen width you want the button width to take
    let pulsatingTextScaler = CGFloat(0.657895)
    
    override func didMove(to view: SKView) {
        
        let startGameButton = SKSpriteNode(imageNamed: "images/newgamebtn.png")
        let textureScale = (desiredWidthRatio/((100 * startGameButton.size.width)/UIScreen.main.bounds.width))
        let newSize = CGSize(width: startGameButton.size.width * textureScale, height: startGameButton.size.height * textureScale)
        
        startGameButton.position = CGPoint(x: size.width/2, y: startGameButton.size.height/2)
        startGameButton.size = newSize
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        let invaderText = PulsatingText(fontNamed: "ChalkDuster")
        invaderText.setTextFontSizeAndPulsate(theText: "HIGHSCORES!", theFontSize: CGFloat((UIScreen.main.bounds.width/10) * pulsatingTextScaler))
        invaderText.position = CGPoint(x: size.width/2, y: size.height - 50) // XXX THIS MAY NEED TO BE SCALED BETTER
        addChild(invaderText)
        
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField?.zPosition = -1000
        starField?.position = CGPoint(x: size.width/2, y: size.height)
        starField?.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        addChild(starField!)
        
        displayHighscores()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first as UITouch!
        let touchLocation = touch?.location(in: self)
        let touchedNode = self.atPoint(touchLocation!)
        
        if touchedNode.name == "startgame" {
            
            let gameScene = GameScene(size: size)
            gameScene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipHorizontal(withDuration: 1.0)
            view?.presentScene(gameScene, transition: transitionType)
        }
        else if touchedNode.name == "clear" {
            
            NSLog("Clear highscores.")
            
            
        }
        
    }
    
    func displayHighscores() {
        
        let horOffset = UIScreen.main.bounds.width/4
        let vertOffset = 10
        let vertStart = UIScreen.main.bounds.height - 200
        let fontSize = CGFloat(16)       // SCALE THIS
        
        let rankLabel = SKLabelNode(fontNamed: "Chalkduster")
        let nameLabel = SKLabelNode(fontNamed: "Chalkduster")
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        
        rankLabel.text = "RANK"
        rankLabel.fontSize = fontSize
        rankLabel.position = CGPoint(x: horOffset/2, y: vertStart)
        
        nameLabel.text = "NAME"
        nameLabel.fontSize = fontSize
        nameLabel.position = CGPoint(x: horOffset*2, y: vertStart)
        
        scoreLabel.text = "SCORE"
        scoreLabel.fontSize = fontSize
        scoreLabel.position = CGPoint(x: horOffset*3 + horOffset/2, y: vertStart)
        
        addChild(rankLabel)
        addChild(nameLabel)
        addChild(scoreLabel)
        
        
        for i in 0 ..< appDelegate.highscores.count {
            
        }
    }

}
