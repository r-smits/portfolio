//
//  PlayerInput.swift
//  Tile
//
//  Created by Ramon Smits on 16/02/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayerInput: SKSpriteNode {
    //let buildWalkingCycle = BuildWalkingCycle.init()
}


class BuildWalkingCycle {
    
    var playerWalkingFrames: [SKTexture] = []
    
    func buildWalkingCycle(_ player: SKSpriteNode) {
        
        let walkingCycle = SKTextureAtlas(named: "WalkingCycle")
        var playerWalkingTextureArray: [SKTexture] = []
        let walkingCycleInt:Int = walkingCycle.textureNames.count
        
        for i in 1...walkingCycleInt {
            let playerWalkingTexture = "Walkingcycle\(i)"
            playerWalkingTextureArray.append(walkingCycle.textureNamed(playerWalkingTexture))
        }
        playerWalkingFrames = playerWalkingTextureArray
    }
}
