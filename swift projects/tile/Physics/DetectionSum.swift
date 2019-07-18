//
//  DetectionSum.swift
//  Tile
//
//  Created by Ramon Smits on 16/03/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import Foundation
import GameKit

class DetectionSum: GKComponent {
    
    let pNode = PlayerNode()
    
    var tileMap: SKTileMapNode!
    var scene: SKScene!

    //if let ground = contact.bodyB.node as? SKSpriteNode {
    
    //let w = (player.size.width / 2) + (ground.size.width / 2)
    //let h = (player.size.height / 2) + (ground.size.height / 2)
    
    //let centerXp = player.position.x + (player.size.width / 2)
    //let centerYp = player.position.y + (player.size.height / 2)
    
    //let centerXg = ground.position.x + (ground.size.width / 2)
    //let centerYg = ground.position.y + (ground.size.height / 2)
    
    //var cX = abs(centerXp - centerXg)
    //var cY = abs(centerYp - centerYg)
    
    //if w <= cX {
    //    print("width collision")
    //}
    
    //if h <= cY {
    //    print("w = ",w, " cX = ", cX, " playerwidth: ", (player.size.width / 2), " groundwidth: ", (ground.size.width / 2))
    
    //print("player: ",player.size.height, " position x: ",player.position.x, "center X: ", centerXp)
    //print("ground: ",ground.size.height, " position x: ",ground.position.x, "center X: ", centerXg)

    
    override func update(deltaTime seconds: TimeInterval) {
        
        
    }
}
