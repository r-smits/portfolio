//
//  NormalState.swift
//  Tile
//
//  Created by Ramon Smits on 27/01/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import SpriteKit
import GameplayKit

class NormalState: GKState {
    
    let physicsDetection = PhysicsDetection()
    
    var addSecondsLeft:Double = 0.0
    var addSecondsRight:Double = 0.0
    
    var pNode:PlayerNode
    var camera:SKCameraNode
        
    init(with node: PlayerNode, and camera: SKCameraNode){
        pNode = node
        self.camera = camera
    }
    
    var aSpeed: CGFloat = 0.0
    var dSpeed: CGFloat = 0.0
    
    override func update(deltaTime seconds: TimeInterval) {
        
        if pNode.grounded == true {
            aSpeed = pNode.groundAccel
            dSpeed = pNode.groundDecel
        } else {
            aSpeed = pNode.AirAccel
            dSpeed = pNode.AirDecel
        }
        
        if pNode.left {
            pNode.hSpeed = approach(start: pNode.hSpeed, end: -pNode.walkSpeed, shift: aSpeed)
        } else if pNode.right {
            pNode.hSpeed = approach(start: pNode.hSpeed, end: pNode.walkSpeed, shift: aSpeed)
        } else {
            pNode.hSpeed = approach(start: pNode.hSpeed, end: 0.0, shift: dSpeed)
        }
        
        if pNode.grounded == true {
            // When the player is falling you cannot jump again
            if (pNode.physicsBody?.velocity.dy)! != CGFloat(0.0) {
                pNode.jump = false
            }
            
            pNode.landed = false
        }
        
        if pNode.grounded == true {
            
            // Doesn't get triggered, but should get triggered to show that player can jump again
            if pNode.landed {
                pNode.physicsBody?.velocity = CGVector(dx: (pNode.physicsBody?.velocity.dx)!, dy: 0.0)
                pNode.landed = true
            }
            // if Jump = yes, apply a certain amount of impulse
            
            if pNode.jump {
                pNode.grounded = false
                pNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: pNode.maxJump))
            }
        }
        
        
        pNode.xScale = approach(start: pNode.xScale, end: 1, shift: 0.05)
        pNode.yScale = approach(start: pNode.yScale, end: 1, shift: 0.05)
        
        pNode.position.x = pNode.position.x + pNode.hSpeed
        //camera.position = pNode.position
    }
    
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat {
        
        if(start < end) {
            return min (start + shift, end);
        } else {
            return max (start - shift, end);
        }
        
        
    }
    
}
