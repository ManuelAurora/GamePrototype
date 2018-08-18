//
//  MoveComponent.swift
//  Prototype
//
//  Created by manuely.aurora on 17.08.2018.
//  Copyright © 2018 manuely.aurora. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol MovementDelegate: class {
    func characterFinishMovement()
}

final class MoveComponent: GKComponent {
    private let physicsBody: SKPhysicsBody
    private let node: SKNode
    private let speed: CGFloat
    var delegate: MovementDelegate?
    
    init(node: SKNode, speed: CGFloat) {
        self.physicsBody = node.physicsBody!
        self.node = node
        self.speed = speed
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveBy(path: [CGPoint]) {
        var actions: [SKAction] = []
        var currentPosition: CGPoint = .zero
        var distance: CGFloat = 0
        var timeInterval: TimeInterval = 0
        
        path.forEach { point in
            if currentPosition == .zero {
                currentPosition = point
            } else {
                distance = (point - currentPosition).length()
                timeInterval = TimeInterval(distance / speed)
                actions.append(.move(to: point, duration: timeInterval))
                currentPosition = point
            }
        }
        actions.append(SKAction.run { [weak self] in
            self?.delegate?.characterFinishMovement()
        })
        node.run(.sequence(actions))
    }
}
