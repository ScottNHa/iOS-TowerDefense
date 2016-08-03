//
//  VisualComponent.swift
//  TowerDefenseTest
//
//  Created by Scott Ha on 7/28/16.
//  Copyright © 2016 Scott Ha. All rights reserved.
//

import GameplayKit
import SpriteKit

class VisualComponent: GKComponent {
	var scene:GameScene!
	var sprite: SKSpriteNode!
	var coordinate:int2!
	
	init(scene: GameScene, sprite: SKSpriteNode, coordinate: int2){
		self.scene = scene
		self.sprite = sprite
		self.coordinate = coordinate
	}
}
