//
//  GameScene.swift
//  myFirstGame
//
//  Created by 왕승현 on 2016. 3. 1..
//  Copyright (c) 2016년 왕승현. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    let manager = CMMotionManager()
    var button: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        button = SKSpriteNode(imageNamed: "run.png")
        button.size = CGSize(width: 300.0, height: 140.0)
        button.position = CGPoint(x: CGRectGetMidX(self.frame) , y: CGRectGetMinY(self.frame) + 170)
        self.addChild(button)
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
        
        //manager.startAccelerometerUpdates()
        //manager.accelerometerUpdateInterval = 0.1
        //manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
        //    (data, error) in
        //    self.physicsWorld.gravity = CGVectorMake(CGFloat((data?.acceleration.x)! * 100) , CGFloat((data?.acceleration.y)! * 100) )
        //}
        
        for i in 1...10 {
            let body: SKPhysicsBody = SKPhysicsBody(circleOfRadius: 20.0)
            let ball: SKSpriteNode = SKSpriteNode(imageNamed: "\(i).png")
            
            body.dynamic = true
            body.affectedByGravity = true
            
            ball.position.x = 530.0
            ball.position.y = 1200.0
            ball.physicsBody = body
            
            self.addChild(ball)
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if button.containsPoint(location) {
                print("tapped!")
            }
        }
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
