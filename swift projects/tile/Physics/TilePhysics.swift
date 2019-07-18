//
//  TilePhysics.swift
//  Tile
//
//  Created by Ramon Smits on 10/02/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

import Foundation
import GameplayKit

class TilePhysics {
    
    var tileMap: SKTileMapNode!
    var scene: SKScene!

    var tileArray = [SKSpriteNode]()
    var tilePositionArray = [CGPoint]()
    
    init(_ tileMap: SKTileMapNode, _ scene: SKScene){
        self.tileMap = tileMap
        self.scene = scene
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    /////////// RETRIEVING THE SET FROM THE TILEMAP ////////////////
    
    func tilephysics() {
        
        let tilesize = tileMap.tileSize
        let halfwidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tilesize.width
        let halfheight =  CGFloat(tileMap.numberOfRows) / 2.0 * tilesize.height
        
        
        func something() -> Array<Character>
        {
            return ["a", "b", "c"]
        }
        
        
        for col in 0 ..< tileMap.numberOfColumns {
            
            for row in 0 ..< tileMap.numberOfRows {
                
                if (tileMap.tileDefinition(atColumn: col, row: row)?.userData?.value(forKey: "ground") != nil) {
                    
                    let tileDef = tileMap.tileDefinition(atColumn: col, row: row)!
                    let tile = SKSpriteNode()
                    
                    let x = round(CGFloat(col) * tilesize.width - halfwidth + (tilesize.width / 2))
                    let y = round(CGFloat(row) * tilesize.height - halfheight + (tilesize.height / 2))
                    
                    tile.position = CGPoint(x: x, y: y)
                    tile.size = CGSize(width: tileDef.size.width, height: tileDef.size.height)
                    
                    tileArray.append(tile)
                    tilePositionArray.append(tile.position)
                }
            }
        }
        algorithm()
    }
    
    var u = 0
    var d = 0
    var l = 0
    var r = 0
    
    var pSwitch = 0
    
    var dir = [String]()
    var pLoc = [CGPoint]()
    var adT = [CGPoint]()
    
    

    func algorithm(){
        
        let width = tileMap.tileSize.width
        let height = tileMap.tileSize.height
        let rWidth = 0.5 * width
        let rHeight = 0.5 * height
        
        // FANTASY LAND ALGO
        
        
        var ti:Int = 0
        var ti2:Int = 0
        var id:Int = 0
        var dl:CGPoint = CGPoint(x: 0, y: 0)
        
        
        var tLE = [CGPoint]()
        var tRE = [CGPoint]()
        
        for t in tilePositionArray {
            
            if (ti-1 < 0) || (tilePositionArray[ti-1].y != tilePositionArray[ti].y - height) {
                
                dl = CGPoint(x: t.x - rWidth, y: t.y - rHeight)
                
            }
            
            if (ti+1 > tilePositionArray.count-1) {
                tLE.append(dl)
                
                tRE.append(CGPoint(x: t.x + rWidth, y: t.y + rHeight))
                
            } else if (tilePositionArray[ti+1].y != tilePositionArray[ti].y + height) {
                
                if let _ = tRE.first(where: {
                    
                    if $0 == CGPoint(x: t.x + rWidth - width, y: t.y + rHeight) {id = tRE.index(of: $0)!}
                    
                    return $0 == CGPoint(x: t.x + rWidth - width, y: t.y + rHeight)}) {
                    
                    if tLE[id].y == dl.y {
                        
                        tRE[id] = CGPoint(x: t.x + rWidth, y: t.y + rHeight)
                    
                    } else {
                        
                        tLE.append(dl)
                        
                        tRE.append(CGPoint(x: t.x + rWidth, y: t.y + rHeight))
                        
                    }

                } else {
                    
                    tLE.append(dl)
                    
                    tRE.append(CGPoint(x: t.x + rWidth, y: t.y + rHeight))
                    
                }
                
            }

            ti+=1
            
        }
        
        for t in tLE {
            
            let size = CGSize(width: abs(t.x - tRE[ti2].x), height: abs(t.y - tRE[ti2].y))
            let loadnode = SKNode()
            
            loadnode.physicsBody = SKPhysicsBody(rectangleOf: size)
            loadnode.physicsBody?.isDynamic = false
            loadnode.physicsBody?.affectedByGravity = false
            loadnode.physicsBody?.restitution = 0
            
            loadnode.physicsBody?.categoryBitMask = 2
            
            loadnode.position.x = t.x + size.width / 2
            loadnode.position.y = t.y + size.height / 2
            
            scene.addChild(loadnode)
            
            ti2 += 1
            
        }
 

        return
        
 
 
        // OLD ALGO
         
        var pos = tilePositionArray[0]
        var it:Int = 0
        
        for _ in 0...tilePositionArray.count * 2 {
            
            it += 1
            pLoc.append(pos)
            
            //if pLoc.count > 2 && pLoc[pLoc.count-2] == pos {draw();return}
            
            print("pSwitch: ",pSwitch, " pos: ",pos)
            
            u = 0
            d = 0
            l = 0
            r = 0
            
            let tUp = CGPoint(x: pos.x, y: pos.y + height)
            let tLeft = CGPoint(x: pos.x - width, y: pos.y)
            let tDown = CGPoint(x: pos.x, y: pos.y - height)
            let tRight = CGPoint(x: pos.x + width, y: pos.y)
            
            let pUpLeft = CGPoint(x: pLoc[pLoc.count-1].x - rWidth, y: pLoc[pLoc.count-1].y + rHeight)
            let pUpRight = CGPoint(x: pLoc[pLoc.count-1].x + rWidth, y: pLoc[pLoc.count-1].y + rHeight)
            let pDownLeft = CGPoint(x: pLoc[pLoc.count-1].x - rWidth, y: pLoc[pLoc.count-1].y - rHeight)
            let pDownRight = CGPoint(x: pLoc[pLoc.count-1].x + rWidth, y: pLoc[pLoc.count-1].y - rHeight)
            
            if tilePositionArray.contains(tUp) && pLoc.index(of: tUp) == nil {u = 1;print("u: ",u)}
            if tilePositionArray.contains(tLeft) && pLoc.index(of: tLeft) == nil {l = 1;print("l: ",l)}
            if tilePositionArray.contains(tDown) && pLoc.index(of: tDown) == nil {d = 1;print("d: ",d)}
            if tilePositionArray.contains(tRight) && pLoc.index(of: tRight) == nil {r = 1;print("r: ",r)}
            
            if l+d == 0 && pLoc.count > 2 && pos == CGPoint(x: pLoc[0].x + width, y: pLoc[0].y) && pos != pLoc[2] {
                
                if dir[dir.count-1] == "up" {adT.append(pDownLeft)}
                if dir[dir.count-1] == "down" {adT.append(pDownRight)}
                
                print("iterations sw alg: ", it)
                draw()
                return
            }
            
            if l == 1 || u == 1 || r == 1 || d == 1 {
                
                if pSwitch == 2 {
                    
                    if d == 1 {
                        
                        pSwitch = 1
                        
                        pos = tDown; dir.append("down");print("down priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "left" {adT.append(pDownRight)
                        } else if dir.count>1 && dir[dir.count-2] == "right" {adT.append(pUpRight)}

                    } else if l == 1 {
                        
                        pos = tLeft; dir.append("left");print("left priority")

                        if dir.count>1 && dir[dir.count-2] == "up" {adT.append(pDownLeft)
                        } else if dir.count>1 && dir[dir.count-2] == "down" {adT.append(pDownRight)}
                        
                    } else if u == 1 {
                        
                        pos = tUp; dir.append("up");print("up priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "right" {adT.append(pUpLeft)
                        } else if dir.count>1 && dir[dir.count-2] == "left" {adT.append(pDownLeft)}
                        
                    } else if r == 1 {
                        
                        pSwitch = 0
                        
                        pos = tRight;dir.append("right");print("right priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "down" {adT.append(pUpRight)
                        } else if dir.count>1 && dir[dir.count-2] == "up" {adT.append(pUpLeft)}
                        
                    }
                
                } else if pSwitch == 1 {
                    
                    if r == 1 {
                        
                        pSwitch = 0
                        
                        pos = tRight;dir.append("right");print("right priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "down" {adT.append(pUpRight)
                        } else if dir.count>1 && dir[dir.count-2] == "up" {adT.append(pUpLeft)}
                        
                    } else if d == 1 {
                        
                        pos = tDown; dir.append("down");print("down priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "left" {adT.append(pDownRight)
                        } else if dir.count>1 && dir[dir.count-2] == "right" {adT.append(pUpRight)}
                        
                    } else if l == 1 {
                        
                        pos = tLeft; dir.append("left");print("left priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "up" {adT.append(pDownLeft)
                        } else if dir.count>1 && dir[dir.count-2] == "down" {adT.append(pDownRight)}

                    } else if u == 1 {
                        
                        pSwitch = 2
                        
                        pos = tUp; dir.append("up");print("up priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "right" {adT.append(pUpLeft)
                        } else if dir.count>1 && dir[dir.count-2] == "left" {adT.append(pDownLeft)}
                        
                    }
                    
                } else if pSwitch == 0 {
                
                    if l == 1 {
                        
                        pSwitch = 2
                        
                        pos = tLeft; dir.append("left");print("left priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "up" {adT.append(pDownLeft)
                        } else if dir.count>1 && dir[dir.count-2] == "down" {adT.append(pDownRight)}

                    } else if u == 1 {
                        
                        pos = tUp; dir.append("up");print("up priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "right" {adT.append(pUpLeft)
                        } else if dir.count>1 && dir[dir.count-2] == "left" {adT.append(pDownLeft)}
                        
                    } else if r == 1 {
                        
                        pos = tRight;dir.append("right");print("right priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "down" {adT.append(pUpRight)
                        } else if dir.count>1 && dir[dir.count-2] == "up" {adT.append(pUpLeft)}

                    } else if d == 1 {
                        
                        pSwitch = 1
                        
                        pos = tDown; dir.append("down");print("down priority")
                        
                        if dir.count>1 && dir[dir.count-2] == "left" {adT.append(pDownRight)
                        } else if dir.count>1 && dir[dir.count-2] == "right" {adT.append(pUpRight)}

                    }
                }
                
            } else {
                
                let tUpLeft = CGPoint(x: pos.x - rWidth, y: pos.y + rHeight)
                let tUpRight = CGPoint(x: pos.x + rWidth, y: pos.y + rHeight)
                let tDownLeft = CGPoint(x: pos.x - rWidth, y: pos.y - rHeight)
                let tDownRight = CGPoint(x: pos.x + rWidth, y: pos.y - rHeight)
                
                if pLoc.contains(tDown) && pLoc.index(of: tLeft) == nil && pLoc.index(of: tRight) == nil && pLoc.index(of: tUp) == nil {
                    adT.append(tUpLeft);adT.append(tUpRight)
                    dir.append("down");pos = pLoc[pLoc.count - 2]
                    print("one-way tile up")
                    
                } else if pLoc.contains(tUp) && pLoc.index(of: tLeft) == nil && pLoc.index(of: tRight) == nil && pLoc.index(of: tDown) == nil {
                    adT.append(tDownRight);adT.append(tDownLeft)
                    dir.append("up");pos = pLoc[pLoc.count - 2]
                    print("one-way tile down")
                    
                } else if pLoc.contains(tLeft) && pLoc.index(of: tUp) == nil && pLoc.index(of: tRight) == nil && pLoc.index(of: tDown) == nil {
                    
                    pSwitch = 2
                    adT.append(tDownRight);adT.append(tDownLeft)
                    dir.append("left");pos = pLoc[pLoc.count - 2]
                    print("one-way tile right")
                
                } else if pLoc.contains(tRight) && pLoc.index(of: tUp) == nil && pLoc.index(of: tLeft) == nil && pLoc.index(of: tDown) == nil {
                    
                    pSwitch = 0
                    adT.append(tUpLeft); adT.append(tUpRight)
                    dir.append("right");pos = pLoc[pLoc.count - 2]
                    print("one-way tile left")

                }
            }
        }
    }
    
    var carryArray = [SKSpriteNode]()
    var anotherCarry = SKNode()
    var adS2 = [CGPoint]()
    var adTr = [CGPoint]()

    func draw(){

        /// FILTER
        let path = CGMutablePath()
        path.addLines(between: adT)
        
        print(adT)
        let shapeN = SKShapeNode(points: &adT, count: adT.count)
        //shapeN.fillColor = NSColor.blue
        
        //anotherCarry.addChild(shapeN)
        
        scene.addChild(shapeN)
        //shapeN.name = "anotherCarry"
        
        for n in tilePositionArray {if path.contains(n) {tilePositionArray.remove(at: tilePositionArray.index(of: n)!);print("sN contains: ",n)}}

        
        /// SORT ALGORITHM - WORKS AS INTENDED
        print(adT)
        let adS:[CGPoint] = adT.sorted { (a, b) -> Bool in return a.x < b.x }
        
        /// SHAPE DECONSTRUCTION ALGORITHM
        var c1:CGPoint = adT[0]
        var c2:CGPoint = adT[1]
        var ec1:CGPoint = adT[0]
        var ec2:CGPoint = adT[1]
        var it:Int = 0
        
        for _ in adT {
            it += 1
            
            /// SET-UP
            let loadnode = SKSpriteNode()
            
            c1 = ec1
            c2 = ec2
            

            /// ADS2 NOW CONTAINS A SWEEP OF THE COORDINATES OF THE NEXT X FROM C1/C2
            if let _ = adS.first(where: { if $0.x > c1.x {c2.x = $0.x}; return $0.x > c1.x }) {
                adS2 = adS.filter { $0.x == c2.x }
                adS2 = adS2.sorted { (a, b) -> Bool in return a.y > b.y}

                
            
                /// CHECK WHETHER THE TWO STARTING COORDINATES CORRESPOND WITH
                if adS2.contains(CGPoint(x: c2.x , y:c1.y)) || adS2.contains(CGPoint(x: c2.x, y: c2.y)) {
                    
                    let min = adS2.min(by: { (a, b) -> Bool in a.y < b.y })!
                    let max = adS2.max(by: { (a, b) -> Bool in a.y < b.y })!

                    let size = CGSize(width: abs(c1.x - c2.x), height: abs(c1.y - c2.y))
                    
                    loadnode.physicsBody = SKPhysicsBody(rectangleOf: size)
                    loadnode.size = size
                    
                    loadnode.position.x = c1.x + (size.width / 2)
                    loadnode.position.y = c1.y + (size.height / 2) 
                    
                    loadnode.physicsBody?.affectedByGravity = false
                    loadnode.physicsBody?.allowsRotation = false
                    loadnode.physicsBody?.isDynamic = false
                    loadnode.physicsBody?.restitution = 0
                    
                    loadnode.physicsBody?.categoryBitMask = 2
                    
                    carryArray.append(loadnode)

                    if adS2.contains(CGPoint(x: c2.x , y:c1.y)) && adS2.contains(CGPoint(x: c2.x, y: c2.y)) {
                        
                        /// CALLED WHEN THERE'S AN EXTRUSION ON BOTH SIDES
                        if min.y < c1.y {ec1 = min} else {ec1 = adS2.last { $0.y > c1.y }!}
                        if max.y > c2.y {ec2 = max} else {ec2 = adS2.first { $0.y < c2.y }!}
                        
                        print("ec1: ", ec1)
                        print("ec2: ", ec2)
                        print("execute 1")
                    
                    } else if adS2.contains(CGPoint(x: c2.x , y:c1.y)) {
                        
                        /// ALWAYS GETS CALLED WHEN THERE'S AN EXTRUSION DOWNWARDS
                        if min.y < c1.y {ec1 = min} else {ec1 = adS2.last { $0.y > c1.y }!}
                        
                        
                        
                        if let _ = adS2.last(where: {$0.y > c1.y}) {}
                        
                        ec2 = CGPoint(x: c1.x, y: c2.y)
                        
                        print("ec1: ", ec1)
                        print("ec2: ", ec2)
                        print("execute 2")

                    } else if adS2.contains(CGPoint(x: c2.x, y: c2.y)) {
                        
                        /// ALWAYS GETS CALLED WHEN THERE'S AN EXTRUSION UPWARDS
                        ec1 = CGPoint(x: c2.x, y: c1.y)
                        if max.y > c2.y {ec2 = max} else {ec2 = adS2.first { $0.y < c2.y }!}

                        print("ec1: ", ec1)
                        print("ec2: ", ec2)
                        print("execute 3")

                    }
                    
                } else {
                    /// A NEW LINE HAS JUST STARTED
                }
            } else {print("iterations sdc alg: ", it);break}
        }
        
        
        /// NEXT SHAPE
        
        if tilePositionArray.count > 0 {
            
            u = 0
            d = 0
            l = 0
            r = 0
    
            pSwitch = 0
            
            dir = [String]()
            pLoc = [CGPoint]()
            adT = [CGPoint]()
            
            algorithm()
            return
            
        } else {
            
            for shape in carryArray { scene.addChild(shape)}
            //anotherCarry.name = "anotherCarry"
            //scene.addChild(anotherCarry)
            //anotherCarry.isHidden = true
            return
        }
    }
 }
 

