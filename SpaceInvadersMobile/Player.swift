//
//  Player.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    
    let desiredWidthRatio : CGFloat = 12 // Percentage of screen width you want the player's width to take
    
    private var canFire = true
    private var invincible = false
    
    private var lives:Int = 3 {
        didSet {
            if (lives < 0) {
                kill()
            }
            else {
                respawn()
            }
        }
    }

    init() {
        
        let texture = SKTexture(imageNamed: "playerShip1_blue1")
        let textureScale = (desiredWidthRatio/((100 * texture.size().width)/UIScreen.main.bounds.width))
        let newSize = CGSize(width: texture.size().width * textureScale, height: texture.size().height * textureScale)

        super.init(texture: texture, color: SKColor.clear, size: newSize)
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: newSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Player
        self.physicsBody?.contactTestBitMask = CollisionCategories.InvaderBullet | CollisionCategories.Invader
        self.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.allowsRotation = false
        
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animate() {
        var playerTextures: [SKTexture] = []
        
        for i in 1...2 {
            playerTextures.append(SKTexture(imageNamed: "playerShip1_blue\(i)"))
        }
        
        let playerAnimation = SKAction.repeatForever(SKAction.animate(with: playerTextures, timePerFrame: 0.1))
        self.run(playerAnimation)
        
    }
    
    func die() {
        if(invincible == false){
            lives -= 1
        }
    }
    
    func kill() {
        
        NSLog("Player kill")
        
        invaderNum = 1
        
        let gameOverScene = GameOverScene(size: self.scene!.size)
        gameOverScene.scaleMode = self.scene!.scaleMode
        
        let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
        self.scene!.view!.presentScene(gameOverScene,transition: transitionType)

    }
    
    func respawn() {
        
        NSLog("Player is respawning.")
        
        invincible = true
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.4)
        let fadeInAction = SKAction.fadeIn(withDuration: 0.4)
        
        let fadeOutIn = SKAction.sequence([fadeOutAction,fadeInAction])
        let fadeOutInAction = SKAction.repeat(fadeOutIn, count: 5)
        
        let setInvicibleFalse = SKAction.run(){
            self.invincible = false
        }
        run(SKAction.sequence([fadeOutInAction,setInvicibleFalse]))
        
    }
    
    func fireBullet(scene: SKScene) {
        
        if(!canFire){
            return
        }
        else{
            
            canFire = false
            
            let bullet1 = PlayerBullet(imageName: "laserBlue01", bulletSound: "sfx_laser1")
            bullet1.position.x = self.position.x - self.size.width/2
            bullet1.position.y = self.position.y + self.size.height/2
            scene.addChild(bullet1)
            
            let bullet2 = PlayerBullet(imageName: "laserBlue01", bulletSound: nil)
            bullet2.position.x = self.position.x + self.size.width/2
            bullet2.position.y = self.position.y + self.size.height/2
            scene.addChild(bullet2)
            
            let moveBulletAction1 = SKAction.move(to: CGPoint(x:self.position.x - self.size.width/2,
                                                              y: scene.size.height + bullet1.size.height),
                                                              duration: 1.0)
            let moveBulletAction2 = SKAction.move(to: CGPoint(x:self.position.x + self.size.width/2,
                                                              y: scene.size.height + bullet2.size.height),
                                                              duration: 1.0)
            
            let removeBulletAction = SKAction.removeFromParent()
            
            bullet1.run(SKAction.sequence([moveBulletAction1, removeBulletAction]))
            bullet2.run(SKAction.sequence([moveBulletAction2, removeBulletAction]))
            
            let waitToEnableFire = SKAction.wait(forDuration: 0.5) // XXX OG duration was 0.5
            run(waitToEnableFire,completion:{
                self.canFire = true
            })
        }
    }
    
    public func getPlayersLives() -> Int {
        return lives
    }
    
    public func isPlayerInvincible() -> Bool {
        return invincible
    }
}
