//
//  SpriteComponentFactory.swift
//  Prototype
//
//  Created by manuely.aurora on 18.08.2018.
//  Copyright © 2018 manuely.aurora. All rights reserved.
//

import SpriteKit

final class SpriteComponentFactory {
    func spriteForCharater(type: CharacterFactory.CharacterType) -> SpriteComponent {
        switch type {
        case .player:
            let component = SpriteComponent(texture: SKTexture(imageNamed: "idle0001"),
                                            size: CGSize(width: 128, height: 128))
            return component
        }
    }
}

