//
//  GameScene.swift
//  TowerDefenseTest
//
//  Created by Scott Ha on 7/28/16.
//  Copyright (c) 2016 Scott Ha. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	// Variables for Grid
    var width:CGFloat!
    var height:CGFloat = 9  // defaults the number of height boxes to 9
    var boxSize:CGFloat!
    var gridStart:CGPoint!
	
	// Variables for Pathfinding
	var graph: GKGridGraph!
    
    override func didMoveToView(view: SKView) {
       createGrid() // call to createGrid function
		
		graph = GKGridGraph(fromGridStartingAt: int2(0,0), width: Int32(width), height: Int32(height), diagonalsAllowed: false)
		
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInNode(self)
		let coordinate = coordinateForPoint(location)
		createTowerAt(coordinate)
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
	
	func coordinateForPoint(point: CGPoint) -> int2 {
		return int2(Int32((point.x - gridStart.x) / boxSize), Int32((point.y - gridStart.y) / boxSize))
	}
	
	func pointForCoordinate(coordinate: int2) -> CGPoint {
		return CGPointMake(CGFloat(coordinate.x) * boxSize + gridStart.x + boxSize / 2, CGFloat(coordinate.y) * boxSize + gridStart.y + boxSize / 2)
	}
	
	func createTowerAt(coordinate: int2){
		if let node = graph.nodeAtGridPosition(coordinate){
			let tower = GKEntity()
			
			let towerSprite = SKSpriteNode(imageNamed: "turret")
			towerSprite.position = pointForCoordinate(coordinate)
			towerSprite.size = CGSize(width: boxSize * 0.9, height: boxSize * 0.9)
			
			let visualComponent = VisualComponent(scene: self, sprite: towerSprite, coordinate: coordinate)
			tower.addComponent(visualComponent)
			
			addChild(towerSprite)
			graph.removeNodes([node])
			
			// update path
		}
	}
    
    func createGrid(){
        let grid = SKNode() // instantiate an SKNode
        
        let usableWidth = size.width * 0.9      // use only 90% of the screen height
        let usableHeight = size.height * 0.8    // use only 80% of the screen width
        
        boxSize = usableHeight/height           // boxSize is usableHeight / 9
        
        width = CGFloat(Int(usableWidth / boxSize)) // determine how many boxes we can make lengthwise
        
        let offsetX = (size.width - boxSize * width) / 2    // find the middle of the screen for grid
        let offsetY = (size.height - boxSize * height) / 2  // find the middle of the screen for grid
        
        for col in 0 ..< Int(width){
            for row in 0 ..< Int(height){
                let path = UIBezierPath(rect: CGRect(x: boxSize * CGFloat(col), y: boxSize * CGFloat(row), width: boxSize, height: boxSize))    // using the x and y coordinate, make a path node
                let box = SKShapeNode(path: path.CGPath)    // attach path to box
                
                box.strokeColor = UIColor.grayColor()   // color the box
                box.alpha = 0.3							// give the box a slight see through look
                grid.addChild(box)						// add the box to the grid node
            }
        }
        
        gridStart = CGPointMake(offsetX, offsetY)		// determine the center
        grid.position = gridStart						// place the grid in center
        addChild(grid)									// add the grid to the scene
    }
}
