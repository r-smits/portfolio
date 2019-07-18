//
//  PlayerPhysics.swift
//  Tile
//
//  Created by Ramon Smits on 10/02/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import Foundation
import GameKit
import GameplayKit

class PlayerNode: SKSpriteNode {
    
    var left = false
    var right = false
    var down = false
    
    var jump = false
    var grounded:Bool = false
    var landed:Bool = false
    
    var maxJump:CGFloat = 17

    var hSpeed:CGFloat = 0.0
    var walkSpeed:CGFloat = 3

    var AirAccel: CGFloat = 0.1
    var AirDecel: CGFloat = 0.0
    var groundAccel: CGFloat = 1.0
    var groundDecel: CGFloat = 0.5
    
    var a:CGFloat?
    var b:CGFloat?
    var c:CGFloat?
    var d:CGFloat?
    
    var playerWalkingFrames: [SKTexture] = []
    
    func buildWalkingCycle() {
        
        let walkingCycle = SKTextureAtlas(named: "WalkingCycle")
        var playerWalkingTextureArray: [SKTexture] = []
        let walkingCycleInt:Int = walkingCycle.textureNames.count
        
        for i in 1...walkingCycleInt {
            let playerWalkingTexture = "Walkingcycle\(i)"
            playerWalkingTextureArray.append(walkingCycle.textureNamed(playerWalkingTexture))
        }
        playerWalkingFrames = playerWalkingTextureArray
    }
    
    var stateMachine:GKStateMachine?
    
    func setUpStateMachine(_ camera: SKCameraNode){
        let normalState = NormalState(with: self, and: camera)
        stateMachine = GKStateMachine(states: [normalState])
        stateMachine?.enter(NormalState.self)
    }
}
