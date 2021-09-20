//
//  Weapon.swift
//  RPG in Command Line
//
//  Created by Aymerik Vallejo on 08/09/2021.
//

import Foundation

class Weapon {
    
    enum WeaponType {
        
        case attack
        
        case heal
        
    }
    
    // Définition des propriétés de classe
    var name: String
    
    var damage: Int
    
    var heal: Int
    
    var weaponType: WeaponType
    
    // Initialisation de celle ci
    init(name: String, damage: Int, heal: Int, weaponType: WeaponType) {
        
        self.name = name
        
        self.damage = damage
        
        self.heal = heal
        
        self.weaponType = weaponType
        
    }
    
    func weaponStats() -> String { // Affiche simplement les statistiques de l'arme
        
        return "Dégats: \(self.damage), Soins: \(self.heal)"
        
    }
    
}

class Sword: Weapon { // Création d'une arme pour une classe de personnage
    
    init() {
        
        super.init(name: "Épée du seigneur des Abysses", damage: 80, heal: 10, weaponType: .attack)
        
    }
}

class Axe: Weapon { // Création d'une arme pour une classe de personnage
    
    init() {
        
        super.init(name: "Hâche absorbeuse d'ame", damage: 110, heal: 10, weaponType: .attack)
        
    }
}

class Bow: Weapon { // Création d'une arme pour une classe de personnage
    
    init() {
        
        super.init(name: "Arc de broyeur impitoyable", damage: 70, heal: 10, weaponType: .attack)
        
    }
}

class MagicStick: Weapon { // Création d'une arme pour une classe de personnage
    
    init() {
        
        super.init(name: "Lanceur de jugement condamné", damage: 90, heal: 10, weaponType: .attack)
    }
}

class HealingStick: Weapon { // Création d'une arme pour une classe de personnage
    
    init() {
        
        super.init(name: "Cithare orientale de plume de cerf volant", damage: 10, heal: 75, weaponType: .heal)
    }
}
