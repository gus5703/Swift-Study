//
//  GameScene.swift
//  Maze
//
//  Created by 왕승현 on 2016. 3. 1..
//  Copyright (c) 2016년 왕승현. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    let joystick = SKSpriteNode(imageNamed: "joystick")
    let ball = SKSpriteNode(imageNamed: "ball")
    let cam = SKCameraNode()
    
    
    var playerDeg: CGFloat = 0
    var stickActive: Bool = true
    var player: SKSpriteNode = SKSpriteNode()
    var zombies: [SKSpriteNode] = []
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.camera = cam
        
        self.addChild(joystick)
        joystick.position.x = player.position.x - 50
        joystick.position.y = player.position.y - 200
        
        self.addChild(ball)
        ball.position = joystick.position

        player = self.childNodeWithName("player") as! SKSpriteNode
        
        ball
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if stickActive == true {
            
                let vector = CGVector(dx: location.x - joystick.position.x, dy: location.y - joystick.position.y)
                let angle = atan2(vector.dy, vector.dx)
                let deg = angle * CGFloat( 180 / M_PI)
                playerDeg = deg + 180
                //print(deg + 180)

                let length: CGFloat = joystick.frame.size.height / 2
            
                let xDist: CGFloat = sin(angle - 1.57079633) * length
                let yDist: CGFloat = cos(angle - 1.57079633) * length
            
                if (CGRectContainsPoint(joystick.frame, location)) {
                    ball.position = location
                } else {
                    ball.position = CGPointMake(joystick.position.x - xDist, joystick.position.y + yDist)
                }
                
                switch(deg + 180) {
                case 337...359, 0...22 :
                    player.position.x -= 1
                case 23...67 :
                    player.position.x -= 1
                    player.position.y -= 1
                case 68...112 :
                    player.position.y -= 1
                case 113...157 :
                    player.position.y -= 1
                    player.position.x += 1
                case 158...202 :
                    player.position.x += 1
                case 203...247 :
                    player.position.x += 1
                    player.position.y += 1
                case 248...292 :
                    player.position.y += 1
                case 293...336 :
                    player.position.y += 1
                    player.position.x -= 1
                default:
                    break
                }
                
                player.zRotation = angle - 1.57079633
                
            }
        }
    }
    
    func move() {
        var animation: SKAction = SKAction()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if CGRectContainsPoint(joystick.frame, location) {
                stickActive = true
            } else {
                print("false")
                stickActive = false
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if stickActive == true {
            let move: SKAction = SKAction.moveTo(joystick.position, duration: 0.2)
            move.timingMode = .EaseOut
            ball.runAction(move)
            stickActive = false
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if stickActive == true {
            switch(playerDeg) {
            case 337...359, 0...22 :
                player.position.x -= 2
            case 23...67 :
                player.position.x -= 1
                player.position.y -= 1
            case 68...112 :
                player.position.y -= 2
            case 113...157 :
                player.position.y -= 1
                player.position.x += 1
            case 158...202 :
                player.position.x += 2
            case 203...247 :
                player.position.x += 1
                player.position.y += 1
            case 248...292 :
                player.position.y += 2
            case 293...336 :
                player.position.y += 1
                player.position.x -= 1
            default:
                break
            }
        }
        joystick.position.x = player.position.x - 50
        joystick.position.y = player.position.y - 200
        cam.position = player.position
    }
}
