//
//  Chest.swift
//  RPG in Command Line
//
//  Created by Aymerik Vallejo on 08/09/2021.
//

import Foundation

class Chest {
    
    var chestAlreadyProposed = false
    
    let randomWeapon: [Weapon] = [
        
        Weapon(name: "Sucette déja utilisé", damage: 20, heal: 1, weaponType: .attack),
        Weapon(name: "Lance de la Mort", damage: 200, heal: 20, weaponType: .attack),
        Weapon(name: "Matraque de templier psionique", damage: 200, heal: 30, weaponType: .attack),
        Weapon(name: "Eventail de la prophétie", damage: 20, heal: 250, weaponType: .heal),
        Weapon(name: "Epée en bois", damage: 40, heal: 5, weaponType: .attack),
        Weapon(name: "Baton d'entrainement", damage: 20, heal: 50, weaponType: .heal),
        Weapon(name: "Etoile déscendente", damage: 50, heal: 60, weaponType: .attack)
        
    ]
    
    // Select random weapon
    func randomWeapons() -> Weapon {
        
        let randomIndex = arc4random_uniform(7)
        
        return randomWeapon[Int(randomIndex)]
        
    }
    
    
}

// randomWeaponMayAppear(for: characters[index])
// var chestAlreadyProposed = false    dans Player
