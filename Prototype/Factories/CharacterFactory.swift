//
//  CharacterFactory.swift
//  Prototype
//
//  Created by manuely.aurora on 18.08.2018.
//  Copyright © 2018 manuely.aurora. All rights reserved.
//

import SpriteKit

final class CharacterFactory {
    enum CharacterType {
        case player
    }
    
    private let spriteComponentFactory: SpriteComponentFactory
    
    func getCharacterOf(type: CharacterType) -> Character {
        let spriteComponent = spriteComponentFactory.spriteForCharater(type: type)
        return Character(spriteComponent: spriteComponent)
    }
    
    init(spriteComponentFactory: SpriteComponentFactory) {
       self.spriteComponentFactory = spriteComponentFactory
    }
}

