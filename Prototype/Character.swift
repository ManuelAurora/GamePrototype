//
//  Character.swift
//  Prototype
//
//  Created by manuely.aurora on 17.08.2018.
//  Copyright © 2018 manuely.aurora. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Character: GKEntity {
    lazy var node: SKSpriteNode = {
        return spriteComponent.node
    }()
    
    private let spriteComponent: SpriteComponent
    private lazy var animationComponent: AnimationComponent = {
        let texturesIdle: [SKTexture] = (1...18).map { number in
            let additional = number > 9 ? "" : "0"
            return SKTexture(imageNamed: "idle00\(additional)\(number)")
        }
        
        let texturesWalk: [SKTexture] = (1...25).map { number in
            let additional = number > 9 ? "" : "0"
            return SKTexture(imageNamed: "walk00\(additional)\(number)")
        }
        
        let idleAnimation = SKAction.repeatForever(.animate(with: texturesIdle, timePerFrame: 0.08))
        let walkAnimation = SKAction.repeatForever(.animate(with: texturesWalk, timePerFrame: 0.03))
        return AnimationComponent(node: node, animations: [.idle: idleAnimation,
                                                           .goLeft: walkAnimation,
                                                           .goRight: walkAnimation])
    }()
    
    private lazy var moveComponent: MoveComponent = {
        return MoveComponent(node: node, speed: 80)
    }()
    
    var position: CGPoint {
        return spriteComponent.node.position
    }
    
    init(imageName: String) {
        spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName),
                                          size: CGSize(width: 100, height: 100))
        super.init()
        node.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        node.physicsBody?.affectedByGravity = false
        addComponent(spriteComponent)
        addComponent(moveComponent)
        addComponent(animationComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        animationComponent.animate(state: .idle)
    }
    
    func goTo(positions: [CGPoint]) {
        moveComponent.moveBy(path: positions)
        animationComponent.animateMovementBy(vector: node.physicsBody!.velocity)
    }
}

