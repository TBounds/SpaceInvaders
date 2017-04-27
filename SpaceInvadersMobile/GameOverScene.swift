//
//  GameOverScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/27/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene, UITextFieldDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let desiredWidthRatio : CGFloat = 45 // Percentage of screen width you want the button width to take
    let pulsatingTextScaler = CGFloat(0.657895)
    let scoreTextScaler = CGFloat(0.657895)
    
    let maxNameLength = 16
    
    override func didMove(to view: SKView) {
        
        let startGameButton = SKSpriteNode(imageNamed: "images/newgamebtn.png")
        let textureScale = (desiredWidthRatio/((100 * startGameButton.size.width)/UIScreen.main.bounds.width))
        let newSize = CGSize(width: startGameButton.size.width * textureScale, height: startGameButton.size.height * textureScale)
        let edgeSpacing = CGFloat(newSize.width/12)
        
        startGameButton.size = newSize
        startGameButton.position = CGPoint(x: UIScreen.main.bounds.width - startGameButton.size.width/2 - edgeSpacing, y: startGameButton.size.height)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        let highscoreButton = SKSpriteNode(imageNamed: "images/nextlevelbtn.png")
        highscoreButton.size = newSize
        highscoreButton.position = CGPoint(x: startGameButton.size.width/2 + edgeSpacing, y: startGameButton.size.height)
        highscoreButton.name = "savescore"
        addChild(highscoreButton)
        
        let invaderText = PulsatingText(fontNamed: "ChalkDuster")
        invaderText.setTextFontSizeAndPulsate(theText: "GAME OVER!", theFontSize: CGFloat((UIScreen.main.bounds.width/10) * pulsatingTextScaler))
        invaderText.position = CGPoint(x: size.width/2, y: size.height/2 + 300)
        addChild(invaderText)
        
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField?.zPosition = -1000
        starField?.position = CGPoint(x: size.width/2, y: size.height)
        starField?.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        addChild(starField!)
        
        
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "\(appDelegate.score)"
        scoreLabel.fontSize = CGFloat((UIScreen.main.bounds.width/10) * scoreTextScaler) // XXX ADJUST TO SCREEN WIDTH
        scoreLabel.position = CGPoint(x: UIScreen.main.bounds.width/2,
                                      y: invaderText.position.y - 50)
        addChild(scoreLabel)
        
        displayHighscores()
        

        
    }
    
    func displayHighscores() {
        
        let horOffset = UIScreen.main.bounds.width/4
        let vertOffset = CGFloat(30)
        let vertStart = UIScreen.main.bounds.height - 200
        let fontSize = CGFloat(16)       // SCALE THIS
        
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
            
            name.text = appDelegate.highscores[i].name
            name.fontSize = fontSize
            name.position = CGPoint(x: horOffset*2, y: vertStart - (vertOffset * CGFloat(i + 1)))
            
            score.text = "\(appDelegate.highscores[i].score)"
            score.fontSize = fontSize
            score.position = CGPoint(x: horOffset*3 + horOffset/2, y: vertStart - (vertOffset * CGFloat(i + 1)))
            
            addChild(rank)
            addChild(name)
            addChild(score)
        }
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
        else if touchedNode.name == "savescore" {
            
            NSLog("Pop up box to enter name.")
            
            let nameField = UITextField(frame: CGRect(x: 50, y: 50, width: 300, height: 25))
            nameField.placeholder = "Enter your name."
            nameField.textColor = UIColor.black
            nameField.returnKeyType = UIReturnKeyType.done
            nameField.borderStyle = UITextBorderStyle.roundedRect
            nameField.backgroundColor = UIColor.white
            nameField.delegate = self
            view?.addSubview(nameField)
            
//            let highscoreScene = GameOverScene(size: size)
//            highscoreScene.scaleMode = scaleMode
//            
//            let transitionType = SKTransition.flipHorizontal(withDuration: 1.0)
//            view?.presentScene(highscoreScene, transition: transitionType)
            
            
        }
        
    }
    
    // http://stackoverflow.com/questions/24710041/adding-uitextfield-on-uiview-programmatically-swift/32602425
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NSLog("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NSLog("poop")

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.characters.count // for Swift use count(newText)
        
        return numberOfChars <= maxNameLength;

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NSLog("TextField should snd editing method called")
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NSLog("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }


}
