//
//  AnimationComponent.swift
//  Prototype
//
//  Created by manuely.aurora on 17.08.2018.
//  Copyright © 2018 manuely.aurora. All rights reserved.
//

import SpriteKit
import GameplayKit

final class AnimationComponent: GKComponent {
    enum StateToAnimate {
        case goBottom
        case goTop
        case goLeft
        case goRight
        case idle
    }
    
    private let animations: [StateToAnimate: SKAction]
    private let node: SKNode
    
    init(node: SKNode, animations: [StateToAnimate: SKAction]) {
        self.animations = animations
        self.node = node
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(state: StateToAnimate) {
        guard let animation = animations[state] else { return }
        node.run(animation, withKey: "animation")
    }
    
    func animateMovementBy(vector: CGVector) {
        let state = animationDirectionFor(vector: vector)
        if state == .goLeft {
            node.xScale = -abs(node.xScale)
        }
        if state == .goRight {
            node.xScale = abs(node.xScale)
        }
        animate(state: state)
    }
    
    private func animationDirectionFor(vector: CGVector) -> StateToAnimate {
        let direction: StateToAnimate = {
            if abs(vector.dy) > abs(vector.dx) {
                return vector.dy > 0 ? .goBottom : .goTop
            } else {
                return vector.dx > 0 ? .goLeft : .goRight
            }
        }()
        return direction
    }
}

