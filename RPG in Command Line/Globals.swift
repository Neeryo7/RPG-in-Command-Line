//
//  Global.swift
//  RPG in Command Line
//
//  Created by Aymerik Vallejo on 13/09/2021.
//



let roundsForPlayer1 = [1, 3, 5, 7, 9, 11]
let roundsForPlayer2 = [2, 4, 6, 8, 10, 12]

let randomRoundChestForPlayer1 = roundsForPlayer1.randomElement()
let randomRoundChestForPlayer2 = roundsForPlayer2.randomElement()

// Fonction qui empeche que l'utilisateur entre une chaine de character vide
func readLineWithoutOptional() -> String {
    
    if let retrieval = readLine() {
        
        return retrieval
        
    } else {
        
        return ""
    }
}
