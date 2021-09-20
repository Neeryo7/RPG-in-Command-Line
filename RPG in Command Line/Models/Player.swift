//
//  Player.swift
//  RPG in Command Line
//
//  Created by Aymerik Vallejo on 08/09/2021.
//


class Player {
    
    
    // Définition des propriétés de classe
    var defaultName: String
    
    var name: String
    
    var isPlayerAlive: Bool = true
    
    var characters = [Character]()
    
    var allCharactersName = [String]()
    
    
    // Initialisation des propriétés de classe
    init(defaultName: String, name: String, isPlayerAlive: Bool) {
        
        self.defaultName = defaultName
        
        self.name = name
        
        self.isPlayerAlive = isPlayerAlive
    }
    
    // Fonction qui permet de donner des noms au personnages choisis
    func createCharacterName() -> String {
        
        let choosenName = readLineWithoutOptional()
        
        let choice = choosenName.trimmingCharacters(in: .whitespaces)
        
        if choice.count < 4 { // On Vérifie si les données rentré sont bien supérieur à 4 caractères
            
            print("Le nom du personnage dois faire au moins 4 caractères.")
            
        } else if allCharactersName.contains(choice) { // On vérifie si le nom n'est pas déjà pris
            
            print("Ce nom est déjà pris.")
            
        } else {
            
            return choice
            
        }
        
        return createCharacterName()
    }
    
    // Fonction qui permet la selection de 3 personnages
    func characterSelection() {
        
        let fighter = Fighter(name: "Combattant")
        
        let viking = Viking(name: "Viking")
        
        let ranger = Ranger(name: "Ranger")
        
        let mage = Mage(name: "Mage")
        
        let monk = Monk(name: "Moine")
        
        // Création d'une boucle qui demande au joueur de choisir 3 classes de personnage.
        while characters.count < 3 {
            
            print("------------------------------------------------------------------\n"
                    
                    + "\(self.name), choisissez une classe pour l'ajouter à votre équipe !\n"
                    
                    + "\n1. ⚔️\(fighter.infosInSelection())" // Appel de la fonction qui donnera les informations de X classe
                    + "\n2. 🪓\(viking.infosInSelection())"
                    + "\n3. 🏹\(ranger.infosInSelection())"
                    + "\n4. 🔥\(mage.infosInSelection())"
                    + "\n5. 🧙‍♂️\(monk.infosInSelection())\n"
                    
                    + "\n------------------------------------------------------------------")
            
            let choosenCharacter = readLineWithoutOptional()
            
            switch choosenCharacter {
            
            case "1":
                
                print("Vous avez choisi un combattant, donnez lui un nom:")
                
                let characterName = createCharacterName() // On demande a l'utilisateur de donner un nom a son personnage
                
                allCharactersName.append(characterName) // On ajoute celui ci dans le tableau de tout les noms des personnages
                
                let choosenCharacter = Fighter(name: characterName) // Le personnage X de la classe X a desormais un nom
                
                characters.append(choosenCharacter) // On ajoute le personnage choisi dans le tableau des personnages
                
                print("\nVotre combattant s'appelle desormais \(characterName).")
                
            case "2":
                
                print("Vous avez choisi un viking, donnez lui un nom:")
                
                let characterName = createCharacterName()
                
                allCharactersName.append(characterName)
                
                let choosenCharacter = Viking(name: characterName)
                
                characters.append(choosenCharacter)
                
                print("\nVotre viking s'appelle desormais \(characterName).")
                
            case "3":
                
                print("Vous avez choisi un ranger, donnez lui un nom:")
                
                let characterName = createCharacterName()
                
                allCharactersName.append(characterName)
                
                let choosenCharacter = Ranger(name: characterName)
                
                characters.append(choosenCharacter)
                
                print("\nVotre ranger s'appelle desormais \(characterName).")
                
            case "4":
                
                print("Vous avez choisi un mage, donnez lui un nom:")
                
                let characterName = createCharacterName()
                
                allCharactersName.append(characterName)
                
                let choosenCharacter = Mage(name: characterName)
                
                characters.append(choosenCharacter)
                
                print("\nVotre mage s'appelle desormais \(characterName).")
                
            case "5":
                
                print("Vous avez choisi un moine, donnez lui un nom:")
                
                let characterName = createCharacterName()
                
                allCharactersName.append(characterName)
                
                let choosenCharacter = Monk(name: characterName)
                
                characters.append(choosenCharacter)
                
                print("\nVotre moine s'appelle desormais \(characterName).")
                
            default:
                
                print("Je n'ai pas compris votre choix")
                
            }
        }
    }
    
    // Fonction qui permet de choisir un personnage pour effectuer une action (attaquer ou soigner). Vérifie que le personnage existe.
    func actionChoice() -> Character {
        
        for(index, character) in characters.enumerated() {
            
            // Affichage ligne par ligne avec les statistiques
            print("""
                   \(index + 1). \(character.name)(\(character.defaultClass)) : \(character.infosInMatch())
                   """)
        }
        
        if let choice = readLine() {
            
            if let intChoice = Int(choice) {
                
                if intChoice >= 1 && intChoice <= characters.count {
                    
                    return characters[intChoice - 1]
                    
                }
            }
        }
        return actionChoice()
    }
    
    func isTeamAlive() -> Bool { // Fonction qui vérifira si tout les personnages d'une équipe sont vivants ou non
        
        var alive = false
        
        for character in characters {
            
            if character.healthPoints > 0 {
                
                alive = true
                
            }
        }
        
        return alive
    }
    
    static func randomWeaponMayAppear(for attackingCharacter: Character) {
        
        let chest = Chest()
        
        if !chest.chestAlreadyProposed {
            
            if game.numberOfRounds == randomRoundChestForPlayer1 || game.numberOfRounds == randomRoundChestForPlayer2 {
                
                print("\n🎁 Une arme secrete plus ou moins puissante viens d'apparaitre. Voulez vous la récupérer ?\n")
                print("oui ou non")
                
                let choice = readLineWithoutOptional()
                
                
                switch choice {
                
                case "oui":
                    
                    print("\(attackingCharacter.name) a échangé son arme [\(attackingCharacter.weapon.name)] infligeant \(attackingCharacter.weapon.damage) dégâts")
                    
                    let randomWeapon = chest.randomWeapons()
                    
                    attackingCharacter.weapon = randomWeapon
                    
                    print("Il est maintenant équipé de l'arme [\(attackingCharacter.weapon.name)] infligeant \(attackingCharacter.weapon.damage) dégâts.")
                    
                case "non":
                    
                    print("Vous avez refusé : \(chest.randomWeapons().name).")
                    
                default:
                    
                    print("Je n'ai pas compris")
                    
                }
                
            }
        }
    }
    
}

