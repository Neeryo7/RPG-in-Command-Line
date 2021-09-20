//
//  Character.swift
//  RPG in Command Line
//
//  Created by Aymerik Vallejo on 08/09/2021.
//


class Character {
    
    // Définition des propriétés de classe
    var defaultClass: String
    
    var name: String
    
    var healthPoints: Int
    
    var weapon: Weapon
    
    var maxHealthPoints: Int
    
    var isAlive: Bool = true
    
    // Initialisation de celles ci
    init(defaultClass: String, name: String, healthPoints: Int, weapon: Weapon, maxHealthPoints: Int) {
        
        self.defaultClass = defaultClass
        
        self.name = name
        
        self.healthPoints =  healthPoints
        
        self.weapon = weapon
        
        self.maxHealthPoints = maxHealthPoints
        
    }
    
    
    func infosInSelection() -> String { // Statistiques des personnages en selection (avant le combat)
        
        return "\(self.name), Points de vie: \(self.healthPoints), Arme: \(self.weapon.name), \(self.weapon.weaponStats())"
        
    }
    
    func infosInMatch() -> String { // Statistiques des personnages (pendant le combat)
        
        return "Points de vie restant: \(self.healthPoints), Stats de l'arme \(self.weapon.weaponStats())"
        
    }
    
    func attack(sufferingCharacter: Character) { // Fonction qui permet d'attaquer
        
        sufferingCharacter.healthPoints -= weapon.damage // Le personnage qui subit perd des points de vie équivalent au dégàts de l'arme
        
        if sufferingCharacter.healthPoints < 0 { // Empeche le personnage qui subit une attaque de decendre en dessous de 0 pv
            
            sufferingCharacter.healthPoints = 0
        }
        
        if sufferingCharacter.healthPoints == 0 { // Si il a 0 pv, le personnage est donc mort.
            
            sufferingCharacter.isAlive = false
            
        }
    }
    
    func heal(healedCharacter: Character) { // Fonction qui permet de soigner
        
        healedCharacter.healthPoints += weapon.heal // Le personnage qui se fait soigner gagne des points de vie équivalent au soin de l'arme
        
        if healedCharacter.healthPoints > healedCharacter.maxHealthPoints { // Empeche la plus value de soin
            
            healedCharacter.healthPoints = healedCharacter.maxHealthPoints // Ne peux pas avoir plus de points de vie que sa vie maximum
            
        }
        
    }
}

class Fighter: Character { // Création d'une classe de personnage
    
    init(name: String) {
        
        super.init(defaultClass: "Combattant", name: name, healthPoints: 200, weapon: Sword(), maxHealthPoints: 200)
        
    }
}

class Viking: Character { // Création d'une classe de personnage
    
    init(name: String) {
        
        super.init(defaultClass: "Viking", name: name, healthPoints: 250, weapon: Axe(), maxHealthPoints: 250)
        
    }
}

class Ranger: Character { // Création d'une classe de personnage
    
    init(name: String) {
        
        super.init(defaultClass: "Ranger", name: name, healthPoints: 180, weapon: Bow(), maxHealthPoints: 180)
        
    }
}

class Mage: Character { // Création d'une classe de personnage
    
    init(name: String) {
        
        super.init(defaultClass: "Mage", name: name, healthPoints: 200, weapon: MagicStick(), maxHealthPoints: 200)
        
    }
}

class Monk: Character { // Création d'une classe de personnage
    
    init(name: String) {
        
        super.init(defaultClass: "Moine", name: name, healthPoints: 150, weapon: HealingStick(), maxHealthPoints: 150)
        
    }
}
