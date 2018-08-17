//
//  AdventureScene.swift
//  Prototype
//
//  Created by manuely.aurora on 17.08.2018.
//  Copyright © 2018 manuely.aurora. All rights reserved.
//

import SpriteKit
import GameplayKit

final class AdventureScene: SKScene {
    private var entities: [GKEntity] = []
    private let player = Character(imageName: "idle0001")
    private lazy var tileMap: SKTileMapNode = {
        return childNode(withName: "Background") as! SKTileMapNode
    }()
    private lazy var tileGraph: GKGridGraph = {
        var graph = GKGridGraph(fromGridStartingAt: vector_int2(0, 0),
                           width: Int32(tileMap.numberOfColumns),
                           height: Int32(tileMap.numberOfRows),
                           diagonalsAllowed: true)

        var obstacles = [vector_int2]()
        
        for column in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                let tile = tileMap.tileDefinition(atColumn: column, row: row)
                guard let userData = tile?.userData,
                let isObstacle = userData["isObstacle"] as? Bool,
                isObstacle == true else { continue }
                let vector = vector2(Int32(column), Int32(row))
               // obstacles.append(GKGridGraphNode.init(gridPosition: vector))
                obstacles.append(vector)
            }
        }
        obstacles.forEach {
            let nodeToRemove = graph.node(atGridPosition: $0) as! GKGraphNode
            graph.remove([nodeToRemove])
        }
        return graph
    }()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        entities.append(player)
        addChild(player.node)
        let startPoint = convert(tileMap.centerOfTile(atColumn: 8, row: 8), from: tileMap)
        player.node.position = startPoint
        
        player.animate()
        
        tileMap.color = .white
    }
    
    override func update(_ currentTime: TimeInterval) {
        entities.forEach { $0.update(deltaTime: currentTime) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        print("SELF LOCATION: \(touch.location(in: self))")
        print("TILEMAP LOCATION: \(touch.location(in: tileMap))")
        let currentPosition = convert(player.position, to: tileMap)
        let currentTileRow = tileMap.tileRowIndex(fromPosition: currentPosition)
        let currentTileColumn = tileMap.tileColumnIndex(fromPosition: currentPosition)
        let currentGraphNode = tileGraph.node(atGridPosition: vector_int2(Int32(currentTileColumn),
                                                                          Int32(currentTileRow)))

        let touchLocation = touch.location(in: tileMap)
        let touchTileRow = tileMap.tileRowIndex(fromPosition: touchLocation)
        let touchTileColumn = tileMap.tileColumnIndex(fromPosition: touchLocation)
        let toGraphNode = tileGraph.node(atGridPosition: vector_int2(Int32(touchTileColumn),
                                                                     Int32(touchTileRow)))
        let path = tileGraph.findPath(from: currentGraphNode!, to: toGraphNode!) as! [GKGridGraphNode]
        
        print("NODE: row:\(touchTileRow) column: \(touchTileColumn)")
        
        let centerPoints = path.map { g -> CGPoint in
            return convert(tileMap.centerOfTile(atColumn: Int(g.gridPosition.x),
                                                row: Int(g.gridPosition.y)), from: tileMap)
        }
        player.goTo(positions: centerPoints)
    }
}

