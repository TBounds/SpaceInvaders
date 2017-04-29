//
//  LevelCompleteScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/13/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import Foundation
import SpriteKit

class LevelCompleteScene: SKScene{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let desiredWidthRatio = CGFloat(50) // Percentage of screen width you want the button width to take
    let pulsatingTextScaler = CGFloat(0.657895)
    let bonusPointTextScaler = CGFloat(0.5)
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black
        
        let continueButton = SKSpriteNode(imageNamed: "continue_button")
        let textureScale = (desiredWidthRatio/((100 * continueButton.size.width)/UIScreen.main.bounds.width))
        let newSize = CGSize(width: continueButton.size.width * textureScale,
                             height: continueButton.size.height * textureScale)
        continueButton.position = CGPoint(x: UIScreen.main.bounds.width/2,
                                          y: continueButton.size.height * 2)
        continueButton.size = newSize
        continueButton.name = "nextlevel"
        addChild(continueButton)
        
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField?.zPosition = -1000
        starField?.position = CGPoint(x: size.width/2, y: size.height)
        starField?.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        addChild(starField!)
        
        let invaderText = PulsatingText(fontNamed: "ChalkDuster")
        invaderText.setTextFontSizeAndPulsate(theText: "LEVEL COMPLETE", theFontSize: CGFloat((UIScreen.main.bounds.width/10) * pulsatingTextScaler))
        invaderText.position = CGPoint(x: size.width/2,
                                       y: size.height - (invaderText.fontSize * 2))
        addChild(invaderText)
        
        let bonusPointsText = SKLabelNode(fontNamed: "ChalkDuster")
        bonusPointsText.text = "Bonus Points"
        bonusPointsText.fontSize = CGFloat((UIScreen.main.bounds.width/10) * pulsatingTextScaler)
        bonusPointsText.position = CGPoint(x: size.width/2,
                                           y: invaderText.position.y - invaderText.fontSize * 4)
        addChild(bonusPointsText)
        
        let spareLivesText = SKLabelNode(fontNamed: "ChalkDuster")
        spareLivesText.text = "Spare Lives x 100 = \(appDelegate.spareLives * 100)"
        spareLivesText.fontSize = CGFloat((UIScreen.main.bounds.width/10) * bonusPointTextScaler)
        spareLivesText.position = CGPoint(x: size.width/2,
                                           y: bonusPointsText.position.y - spareLivesText.fontSize * 1.5)
        addChild(spareLivesText)
        
        let levelPointsText = SKLabelNode(fontNamed: "ChalkDuster")
        levelPointsText.text = "Level x 1000 = \((appDelegate.level - 1) * 1000)"
        levelPointsText.fontSize = CGFloat((UIScreen.main.bounds.width/10) * bonusPointTextScaler)
        levelPointsText.position = CGPoint(x: size.width/2,
                                          y: bonusPointsText.position.y - spareLivesText.fontSize * 1.5 * 2)
        addChild(levelPointsText)
        
        
        
        
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
