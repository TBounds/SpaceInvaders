//
//  GameScene.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

// https://code.tutsplus.com/tutorials/create-space-invaders-with-swift-and-sprite-kit-implementing-gameplay--cms-23372

import SpriteKit
import GameplayKit
import CoreMotion

var invaderNum = 1

struct CollisionCategories{
    static let Invader : UInt32 = 0x1 << 0
    static let Player: UInt32 = 0x1 << 1
    static let InvaderBullet: UInt32 = 0x1 << 2
    static let PlayerBullet: UInt32 = 0x1 << 3
    static let EdgeBody: UInt32 = 0x1 << 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Invader Variables
    let rowsOfInvaders = 4
    var invaderSpeed = (UIScreen.main.bounds.width/384)
    let enemySpacing = CGFloat(1.5) // Spacing mutliplier based on invader height. x1 leaves no vertical space between enemies.
    let leftBounds = CGFloat(30)
    var rightBounds = CGFloat(0)
    var invadersWhoCanFire: [Invader] = []
    let invaderVertShiftCount = CGFloat(20) // How many vertical shifts it would take the enemies to travel from the top to the bottom of the screen.

    // Player Variables
    var player : Player = Player()
    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
    let livesWidthRatio = CGFloat(5) // Percentage lives sprite width takes of screen width
    
    // Level Variables
    var maxLevels = 3
    

    override func didMove(to view: SKView) {
        
//        NSLog("invaderSpeed = \(invaderSpeed)")
//        NSLog("screen height = \(UIScreen.main.bounds.height)")
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField?.zPosition = -1000
        starField?.position = CGPoint(x: size.width/2, y: size.height)
        starField?.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        addChild(starField!)

        backgroundColor = SKColor.black
        rightBounds = self.size.width - 30
        
        setupInvaders()
        setupPlayer()
        invokeInvaderFire()
        setupAccelerometer()
        
        NSLog("\(player.getPlayersLives())")
        
        var positionAdd = CGFloat(10)
        for _ in 1...player.getPlayersLives() {
            let life = SKSpriteNode(imageNamed: "images/player2.png")
            life.size = CGSize(width: 10, height: 10)
            life.position = CGPoint(x: self.frame.size.width * -1.5, y: self.frame.size.height * 0.1)
            
            let lifeIndexMove = SKAction.move(to: CGPoint(x: (size.width * 0.1) + positionAdd, y: size.height * 0.1), duration: TimeInterval(0.7))
            
            life.run(SKAction.sequence([lifeIndexMove]))
            
            addChild(life)
            
            positionAdd = positionAdd + 30.0
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.fireBullet(scene: self)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        moveInvaders()
    }
    
    func setupInvaders() {
        
        var invaderRow = 0
        var invaderCol = 0
        let numberOfInvaders = invaderNum * 2 + 1
        
        for i in 1...rowsOfInvaders {
            invaderRow = i
            
            for j in 1...numberOfInvaders {
                
                invaderCol = j
                
                var tempInvader: Invader = Invader(imageName: "invader1.png")
                switch(Int(arc4random_uniform(3))){
            
                case 1:
                    tempInvader = Invader(imageName: "invader2.png")
                    break
                case 2:
                    tempInvader = Invader(imageName: "invader3.png")
                    break
                default:
                    break
                }
                
                
                let invaderHalfWidth: CGFloat = tempInvader.size.width/2
                let xPositionStart: CGFloat = size.width/2 - invaderHalfWidth - (CGFloat(invaderNum) * tempInvader.size.width) + CGFloat(10)

                tempInvader.position = CGPoint(x:xPositionStart + ((tempInvader.size.width * enemySpacing)*(CGFloat(j-1))),
                                               y:CGFloat(self.size.height - CGFloat(i) * (tempInvader.size.height) * enemySpacing))
                tempInvader.invaderRow = invaderRow
                tempInvader.invaderCol = invaderCol
                
                addChild(tempInvader)
                
                if i == rowsOfInvaders {
                    invadersWhoCanFire.append(tempInvader)
                }
            }
        }
    }
    
    func setupPlayer() {
        player.position = CGPoint(x: self.frame.midX, y: player.size.height/2 + 10)
        addChild(player)
    }
    
    
    //------------------------------------------------------//
    //------------------- Move Enemies ---------------------//
    //------------------------------------------------------//
    func moveInvaders(){
        
        var changeDirection = false
        
        enumerateChildNodes(withName: "invader") { node, stop in
            let invader = node as! SKSpriteNode
            let invaderHalfWidth = invader.size.width/2
            
            invader.position.x -= CGFloat(self.invaderSpeed)
            if(invader.position.x > self.rightBounds - invaderHalfWidth || invader.position.x < self.leftBounds + invaderHalfWidth){
                changeDirection = true
            }
            
        }
        
        if(changeDirection == true){
            
            self.invaderSpeed *= -1
            self.enumerateChildNodes(withName: "invader") { node, stop in
                let invader = node as! SKSpriteNode
                invader.position.y -= CGFloat((UIScreen.main.bounds.height/self.invaderVertShiftCount))
            }
            
            changeDirection = false
        }
        
        
        
    }
    
    func invokeInvaderFire(){
        
        let fireBullet = SKAction.run(){
            self.fireInvaderBullet()
        }
        
        let waitToFireInvaderBullet = SKAction.wait(forDuration: 1.5)
        let invaderFire = SKAction.sequence([fireBullet,waitToFireInvaderBullet])
        let repeatForeverAction = SKAction.repeatForever(invaderFire)
        run(repeatForeverAction)
    }
    
    func fireInvaderBullet(){
        
        if(invadersWhoCanFire.isEmpty){
            invaderNum += 1
            levelComplete()
        }
        else{
            let randomInvader = invadersWhoCanFire.randomElement()
            randomInvader.fireBullet(scene: self)
        }
    }
    
    //------------------------------------------------------//
    //-------------------- Collision -----------------------//
    //------------------------------------------------------//
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)){
            
            if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                return
            }
            
//            let invadersPerRow = invaderNum * 2 + 1
            let theInvader = firstBody.node as! Invader
            let newInvaderRow = theInvader.invaderRow - 1
            let newInvaderCol = theInvader.invaderCol
            
            if(newInvaderRow >= 1){
                
                self.enumerateChildNodes(withName: "invader") { node, stop in
                    
                    let invader = node as! Invader
                    
                    if invader.invaderRow == newInvaderRow && invader.invaderCol == newInvaderCol{
                        self.invadersWhoCanFire.append(invader)
                        stop.pointee = true
                    }
                }
            }
            
            let invaderIndex = findIndex(array: invadersWhoCanFire,valueToFind: firstBody.node as! Invader)
            if(invaderIndex != nil){
                invadersWhoCanFire.remove(at: invaderIndex!)
            }
            
            theInvader.removeFromParent()
            secondBody.node?.removeFromParent()
            
            
        }
        
        if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.InvaderBullet != 0)) {
    
            player.die()
        }
        
        if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Player != 0)) {
   
            player.kill()
            
        }
        
    }
    
    func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    func levelComplete(){
        
        if(invaderNum <= maxLevels){
            
            let levelCompleteScene = LevelCompleteScene(size: size)
            levelCompleteScene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
            view?.presentScene(levelCompleteScene,transition: transitionType)
        }
        else{
            invaderNum = 1
            newGame()
        }
    }
    
    func newGame(){
        
        let gameOverScene = StartGameScene(size: size)
        gameOverScene.scaleMode = scaleMode
        
        let transitionType = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(gameOverScene,transition: transitionType)
    }
    
    func setupAccelerometer(){
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { accelerometerData, error in
            
            let acceleration = accelerometerData!.acceleration
            self.accelerationX = CGFloat(acceleration.x)
        })
    }
    
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: accelerationX * (UIScreen.main.bounds.height + 200), dy: 0)
    }
   
    
}
