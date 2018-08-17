//
//  SpriteComponent.swift
//  Prototype
//
//  Created by manuely.aurora on 17.08.2018.
//  Copyright © 2018 manuely.aurora. All rights reserved.
//

import SpriteKit
import GameplayKit

final class SpriteComponent: GKComponent {
    let node: SKSpriteNode
    
    init(texture: SKTexture, size: CGSize) {
        node = SKSpriteNode(texture: texture, color: .white, size: size)
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
