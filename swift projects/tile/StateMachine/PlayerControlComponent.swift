//
//  PlayerControlComponent.swift
//  Tile
//
//  Created by Ramon Smits on 21/02/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerControlComponent: GKComponent, ControlInputDelegate {
    
    var camera: SKCameraNode?
    
    var pNode: PlayerNode?
    
    func addToScene(scene: SKScene, camera: SKCameraNode) {
        
        if (pNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self){
                pNode = nodeComponent.node as? PlayerNode
                
                self.camera = camera
                
            }
        }
        
    }
    
    func follow(command: String?) {
       
        if pNode != nil {
            switch(command){
                
            case "left":
                pNode?.left = true
                
            case "left unpressed":
                pNode?.left = false
                
            case "right":
                pNode?.right = true
                
            case "right unpressed":
                pNode?.right = false
                
            case "up":
                pNode?.jump = true
               
            case "up unpressed":
                pNode?.jump = false

            default:
                print("button pressed: \(String(describing: command))")
                break
            }
       }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        pNode?.stateMachine?.update(deltaTime: seconds)
        
        //if camera!.position.x - pNode!.position.x > 60 {camera!.position.x = pNode!.position.x+59}
        //if camera!.position.y - pNode!.position.y > 50 {camera!.position.y = pNode!.position.y+49}
        //if camera!.position.x - pNode!.position.x < -60 {camera!.position.x = pNode!.position.x-59}
        //if camera!.position.y - pNode!.position.y < -50 {camera!.position.y = pNode!.position.y-49}
        
        
        if camera!.position.x - pNode!.position.x > 60 {camera!.run(SKAction.moveTo(x: pNode!.position.x+59, duration: 0.1))}
        if (camera!.position.x - pNode!.position.x < -60) {camera!.run(SKAction.moveTo(x: pNode!.position.x-59, duration: 0.1))}
        if (camera!.position.y - pNode!.position.y > 40) {camera!.run(SKAction.moveTo(y: pNode!.position.y+39, duration: 0.1))}
        if (camera!.position.y - pNode!.position.y < -40) {camera!.run(SKAction.moveTo(y: pNode!.position.y-39, duration: 0.1))}
    }
}
