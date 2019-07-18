//
//  PhysicsDetection.swift
//  Tile
//
//  Created by Ramon Smits on 20/02/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import Foundation
import GameplayKit

struct ColliderType {
    static let PLAYER: UInt32 = 0x1 << 0 // 1
    static let GROUND: UInt32 = 0x1 << 1 // 2
    static let WALL: UInt32 = 0x1 << 2 // 4
}

class PhysicsDetection:NSObject, SKPhysicsContactDelegate {
    
    var path:[CGMutablePath]?
    var a1:CGFloat?
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        //contact.bodyA.usesPreciseCollisionDetection = true
        //contact.bodyA.usesPreciseCollisionDetection = true
        
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == ColliderType.PLAYER | ColliderType.GROUND {
                
            if let player = contact.bodyA.node as? PlayerNode {
                                
                player.grounded = true
                    
                let ground = contact.bodyB.node as! SKNode
                    
                /// ANGLE ///
                let pp = player.position
                let gp = ground.position
                    
                // The distance between left to right / up and down
                let b = pp.x - gp.x
                let a = pp.y - gp.y
                    
                let c = hypot(b, a)
                
                
                print("hypothenuse: ",c)
                    
                a1 = asin(a/c) * 180 / CGFloat.pi
                let a2 = asin(b/c) * 180 / CGFloat.pi
                    
                print("cp: ", gp)
                print("pp: ", pp)
                print("angle = ",a1!, "/n & ", a2)
                print("contact took place at ", contact.contactPoint)
                
                // Minkowski
                /*
                print("h: ",ground.frame.height, "w: ",ground.frame.width)
           
                let w = 0.5 * (player.size.width + ground.size.width)
                let h = 0.5 * (player.size.height + ground.size.height)
                let dx = (player.position.x - ground.position.x)
                let dy = (player.position.y - ground.position.y)
                    
                let wy = w * dy
                let hx = h * dx
                
                // Does not always work properly
                if (wy > hx) {
                    if (wy > -hx) {
                        print("top")
                    } else {
                        /* on the left */
                        print("left")
                    }
                } else if (wy > -hx) {
                    print("right")
                } else {
                    print("bottom")
                }
 
                
                    
                print("hp = ",player.size.height / 2,"hg = ", ground.size.height / 2, "w = ",w,"h =  ", h, "dx = ",dx, "dy = ",dy)
                    */
                print("p=bA")
                    
    
                
            } else if let player = contact.bodyB.node as? PlayerNode {
                    
                player.grounded = true
                    
                /// ANGLE ///
                let pp = player.position
                
                // The distance between left to right
                
                // the distance between up and down
 
                // Add to array
                /*var arrayx = [CGPoint]()
                arrayx.append(a)
                arrayx.append(b)
                    
                let pathx = CGMutablePath()
                pathx.addLines(between: arrayx)

                let xsq = pow(b.x, 2)
                let ysq = pow(a.y, 2)
                let c = sqrt(xsq + ysq)
                    
                a1 = asin(a.y/c) * 180 / CGFloat.pi
                let a2 = asin(b.x/c) * 180 / CGFloat.pi
                    
                print("p=bB")
                print("c: ", round(c))
                print("a/c: ", a.x / c)
                print("normal x :",contact.contactNormal.dx)
                print("normal y :",contact.contactNormal.dy)
                print("angle = ",a1, " & ", a2)
                print("sqrt: ", c)*/
            }
        }
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == ColliderType.PLAYER | ColliderType.GROUND {
            
            if let player = contact.bodyA.node as? PlayerNode {
                
                print("collission ended")
                //player.grounded = false
            }
        }
    }
}


//for p in path! {
//if p.contains(CGPoint(x: player.position.x, y: player.position.y - 3)) {
//}
//pow(Double(player.a! - player.b!))


//if let ground = contact.bodyA.node as? SKSpriteNode {

//print("collision B")

