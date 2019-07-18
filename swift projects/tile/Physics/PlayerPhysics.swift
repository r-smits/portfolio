//
//  PlayerPhysics.swift
//  Tile
//
//  Created by Ramon Smits on 10/03/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import Foundation
import GameKit


class PlayerPhysics {

    var player: SKSpriteNode
    var physicsWorld: SKPhysicsWorld
    
    init(_ player: SKSpriteNode, _ physicsWorld: SKPhysicsWorld) {
        self.player = player
        self.physicsWorld = physicsWorld
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func addPhysics(){
        
        player.texture = SKTexture(imageNamed: "CharacterA")
        
        print(player.zPosition)
        
        player.zPosition -= 0
        
        print(player.zPosition)
        
        player.size.width = 40
        player.size.height = 40
    
        // PHYSICSBODY
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (player.size.width)/2, height: player.size.height))
        
        //player.physicsBody?.mass = 200
        
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.restitution = 0
        
        // COLLISSION
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.contactTestBitMask = ColliderType.GROUND
        
        var array = [SKPhysicsBody]()
        
        array.append(player.physicsBody!)
        
    }
}

