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
    let deleteWidthRatio : CGFloat = 5
    
    let pulsatingTextScaler = CGFloat(0.657895)
    let deleteWarningScaler = CGFloat(0.6)
    let highscoreTextScaler = CGFloat(0.6)
    
    var deleteScoresPrompt : Bool = false
    var eraserStart : CGPoint = CGPoint()
    // var scoreTextFontSize : CGSize = CGSize()
    
    override func didMove(to view: SKView) {
        
        displayHighscores() // Called first in order to set eraserStart
        
        let startGameButton = SKSpriteNode(imageNamed: "newgame_button.png")
        let clearHighscoresButton = SKSpriteNode(imageNamed: "images/eraser.png")
        
        let textureScale = (desiredWidthRatio/((100 * startGameButton.size.width)/UIScreen.main.bounds.width))
        let deleteScale = (deleteWidthRatio/((100 * clearHighscoresButton.size.width)/UIScreen.main.bounds.width))
        
        let newSize = CGSize(width: startGameButton.size.width * textureScale, height: startGameButton.size.height * textureScale)
        let newDeleteSize = CGSize(width: clearHighscoresButton.size.width * deleteScale, height: clearHighscoresButton.size.height * deleteScale)
        
        startGameButton.size = newSize
        startGameButton.position = CGPoint(x: size.width/2, y: startGameButton.size.height)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        let invaderText = PulsatingText(fontNamed: "ChalkDuster")
        invaderText.setTextFontSizeAndPulsate(theText: "HIGHSCORES!", theFontSize: CGFloat((UIScreen.main.bounds.width/10) * pulsatingTextScaler))
        invaderText.position = CGPoint(x: size.width/2,
                                       y: size.height - (invaderText.fontSize * 2)) // XXX THIS MAY NEED TO BE SCALED BETTER
        addChild(invaderText)
        
        // Only show eraser if there are scores to delete
        if appDelegate.highscores.count > 0{
            clearHighscoresButton.size = newDeleteSize
            clearHighscoresButton.position = CGPoint(x: eraserStart.x, y: eraserStart.y + (clearHighscoresButton.size.height * 3))
            clearHighscoresButton.name = "clearHighscores"
            addChild(clearHighscoresButton)
        }
        
        
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
            
            if !deleteScoresPrompt {
                
                appDelegate.score = 0
                appDelegate.won = false
                
                let gameScene = GameScene(size: size)
                gameScene.scaleMode = scaleMode
                
                let transitionType = SKTransition.flipHorizontal(withDuration: 1.0)
                view?.presentScene(gameScene, transition: transitionType)
            }
            
        }
        else if touchedNode.name == "clearHighscores" {
            
            if !deleteScoresPrompt {
                NSLog("Clear highscores.")
                
                let desiredWidthRatio : CGFloat = 45 // Percentage of screen width you want the button width to take
                
                let noButton = SKSpriteNode(imageNamed: "no_button.png")
                let textureScale = (desiredWidthRatio/((100 * noButton.size.width)/UIScreen.main.bounds.width))
                let newSize = CGSize(width: noButton.size.width * textureScale, height: noButton.size.height * textureScale)
                let edgeSpacing = CGFloat(newSize.width/12)
                
                noButton.size = newSize
                noButton.zPosition = 5
                noButton.position = CGPoint(x: UIScreen.main.bounds.width - noButton.size.width/2 - edgeSpacing, y: UIScreen.main.bounds.height/2)
                noButton.name = "no"
                addChild(noButton)
                
                
                let yesButton = SKSpriteNode(imageNamed: "yes_button.png")
                yesButton.size = newSize
                yesButton.zPosition = 5
                yesButton.position = CGPoint(x: noButton.size.width/2 + edgeSpacing, y: UIScreen.main.bounds.height/2)
                yesButton.name = "yes"
                addChild(yesButton)
                
                let deleteWarningLabel_1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                deleteWarningLabel_1.name = "warning1"
                deleteWarningLabel_1.fontColor = UIColor.red
                deleteWarningLabel_1.zPosition = 6
                deleteWarningLabel_1.text = "Permanently removing highscores."
                deleteWarningLabel_1.fontSize = CGFloat((UIScreen.main.bounds.width/10) * deleteWarningScaler) // XXX ADJUST TO SCREEN WIDTH
                deleteWarningLabel_1.position = CGPoint(x: UIScreen.main.bounds.width/2,
                                                        y: UIScreen.main.bounds.height - deleteWarningLabel_1.fontSize * 5)
                addChild(deleteWarningLabel_1)
                
                let deleteWarningLabel_2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                deleteWarningLabel_2.name = "warning2"
                deleteWarningLabel_2.fontColor = UIColor.red
                deleteWarningLabel_2.zPosition = 6
                deleteWarningLabel_2.text = "Are you sure?"
                deleteWarningLabel_2.fontSize = CGFloat((UIScreen.main.bounds.width/10) * deleteWarningScaler) // XXX ADJUST TO SCREEN WIDTH
                deleteWarningLabel_2.position = CGPoint(x: UIScreen.main.bounds.width/2,
                                                        y: deleteWarningLabel_1.position.y - deleteWarningLabel_1.fontSize)
                addChild(deleteWarningLabel_2)
                
                let blurElement = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                blurElement.name = "blur"
                blurElement.zPosition = 4
                blurElement.fillColor = SKColor.gray
                blurElement.alpha = 0.6
                blurElement.position = CGPoint(x: UIScreen.main.bounds.width/2, y:UIScreen.main.bounds.height/2)
                addChild(blurElement)
                
                let warningBackground = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width,
                                                                   height: deleteWarningLabel_1.fontSize * 2.5))
                
                // height: deleteWarningLabel_1.fontSize
                
                warningBackground.name = "warningBkgnd"
                warningBackground.zPosition = 5
                warningBackground.fillColor = SKColor.white
                warningBackground.position = CGPoint(x: UIScreen.main.bounds.width/2,
                                                     y: deleteWarningLabel_1.position.y - deleteWarningLabel_1.fontSize/4)
                // y: deleteWarningLabel_1.position.y
                // deleteWarningLabel_1.position.y - (deleteWarningLabel_1.position.y - deleteWarningLabel_2.position.y)/2
                addChild(warningBackground)
                
                
                deleteScoresPrompt = true
            }
            
            
        }
        else if touchedNode.name == "yes" {
            
            NSLog("YES")
            
            // delete scores
            removeHighscoreNodes()
            scene?.childNode(withName: "clearHighscores")?.removeFromParent()
            appDelegate.highscores.removeAll()
            
            // remove yes/no nodes
            removePrompt()
            
            deleteScoresPrompt = false
        }
        else if touchedNode.name == "no" {
            
            NSLog("NO")
            removePrompt()
            
            deleteScoresPrompt = false
        }
        
    
        
    }
    
    func removeHighscoreNodes() {
        
        NSLog("\(appDelegate.highscores.count)")
        
        for _ in 0 ..< appDelegate.highscores.count {
            scene?.childNode(withName: "name")?.removeFromParent()
            scene?.childNode(withName: "score")?.removeFromParent()
            scene?.childNode(withName: "rank")?.removeFromParent()
        }
        
        
    }
    
    func removePrompt() {
        scene?.childNode(withName: "no")?.removeFromParent()
        scene?.childNode(withName: "yes")?.removeFromParent()
        scene?.childNode(withName: "blur")?.removeFromParent()
        scene?.childNode(withName: "warning1")?.removeFromParent()
        scene?.childNode(withName: "warning2")?.removeFromParent()
        scene?.childNode(withName: "warningBkgnd")?.removeFromParent()
        
    }
    
    func displayHighscores() {
        
        let horOffset = UIScreen.main.bounds.width/4
        let vertStart = UIScreen.main.bounds.height - UIScreen.main.bounds.height/5
        let fontSize = CGFloat((UIScreen.main.bounds.width/10) * highscoreTextScaler)
        let vertOffset = fontSize * 1.5
        
        // Dispay column labels for highscore.
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
        
        eraserStart = scoreLabel.position
        
        addChild(rankLabel)
        addChild(nameLabel)
        addChild(scoreLabel)
        
        // Display highscores
        for i in 0 ..< appDelegate.highscores.count {
            let rank = SKLabelNode(fontNamed: "Chalkduster")
            let name = SKLabelNode(fontNamed: "Chalkduster")
            let score = SKLabelNode(fontNamed: "Chalkduster")
            
            rank.text = "\(i + 1)"
            rank.fontSize = fontSize
            rank.position = CGPoint(x: horOffset/2, y: vertStart - (vertOffset * CGFloat(i + 1)))
            rank.name = "rank"
            
            name.text = appDelegate.highscores[i].name
            name.fontSize = fontSize
            name.position = CGPoint(x: horOffset*2, y: vertStart - (vertOffset * CGFloat(i + 1)))
            name.name = "name"
            
            score.text = "\(appDelegate.highscores[i].score)"
            score.fontSize = fontSize
            score.position = CGPoint(x: horOffset*3 + horOffset/2, y: vertStart - (vertOffset * CGFloat(i + 1)))
            score.name = "score"
            
            addChild(rank)
            addChild(name)
            addChild(score)
        }
    }

}
