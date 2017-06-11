//
//  Pet.swift
//  VirtualPetApp
//
//  Created by Nathan Gitter on 11/8/16.
//  Copyright © 2016 Nathan Gitter. All rights reserved.
//

import Foundation

enum PetType {
    case cat
    case dog
    case bird
    case bunny
    case fish
}

class Pet {
    
    let type: PetType
    
    var feedings: Int
    var playSessions: Int
    
    var happiness: Int {
        return playSessions
    }
    
    var foodLevel: Int {
        return feedings - playSessions
    }
    
    init(type: PetType) {
        self.type = type
        self.feedings = 0
        self.playSessions = 0
        
    }
    
    func feed() {
        feedings += 1
        
    }
    
    func play() {
        if foodLevel > 0 {
            playSessions += 1
        }
    }
    
}
