//
//  GameScene.swift
//  Tile
//
//  Created by Ramon Smits on 22/01/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene:SKScene, SKPhysicsContactDelegate {
        
    // GAMESCENE VARIABLES
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime: TimeInterval = 0

    // SETUP TILEMAPNODE AND PLAYER VARIABLES
    var Foregroundnode:SKTileMapNode = SKTileMapNode()
    
    // DELEGATES
    var inputDelegate:ControlInputDelegate?
    let buildWalkingCycle = BuildWalkingCycle()
    var physicsDelegate = PhysicsDetection()
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        
        // LOAD FLOOR
        if let foreground = (self.childNode(withName: "Foreground")) as? SKTileMapNode {
            TilePhysics(foreground, self).tilephysics()
        }
        
        // LOAD PLAYER
        if let player = self.childNode(withName: "player") as? SKSpriteNode {

                if let playerComponent = player.entity?.component(ofType: PlayerControlComponent.self) {
                    
                PlayerPhysics(player, physicsWorld).addPhysics()
                
                (player as! PlayerNode).buildWalkingCycle()
                (player as! PlayerNode).setUpStateMachine(camera!)
                    playerComponent.addToScene(scene: self, camera: camera!)
                    
                
            
                inputDelegate = playerComponent
                physicsWorld.contactDelegate = physicsDelegate
                
            }
        }
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        
    }
    
    var keyArray = [Int]()
    
    override func keyDown(with event: NSEvent) {
        
        switch Int(event.keyCode) {
            
        case 123:
            inputDelegate?.follow(command: "left")
            
        case 124:
            inputDelegate?.follow(command: "right")
            
        case 126:
            inputDelegate?.follow(command: "up")
            
            
        default:
            break
        }
    }

    override func keyUp(with event: NSEvent) {
        
        switch Int(event.keyCode) {
            
        case 123:
            inputDelegate?.follow(command: "left unpressed")

        case 124:
             inputDelegate?.follow(command: "right unpressed")
            
        case 126:
            inputDelegate?.follow(command: "up unpressed")
        
        case 17:
            let foreground = (self.childNode(withName: "Foreground") as! SKTileMapNode)
            let background = (self.childNode(withName: "Background") as! SKTileMapNode)
            
            if foreground.isHidden == false{foreground.isHidden = true;background.isHidden = true} else {foreground.isHidden = false;background.isHidden = false}
            
        case 8:
            if let player = self.childNode(withName: "player") as? SKSpriteNode {
                print(player.entity?.components)
            }
            
        default:
            print(event.keyCode)
            break
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }

}

