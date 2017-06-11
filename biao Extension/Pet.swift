//
//  Pet.swift
//  VirtualPetApp
//
//  Created by 张金林 on 2017/3/28.
//  Copyright © 2017年 Nathan Gitter. All rights reserved.
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
            feedings -= 1
        }
    }
}
