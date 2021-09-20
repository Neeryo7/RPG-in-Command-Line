//
//  Game.swift
//  RPG in Command Line
//
//  Created by Aymerik Vallejo on 08/09/2021.
//

import Foundation

class Game {
    
    
    // Définition des propriétés de la classe
    
    
    var player1 = Player(defaultName: "Joueur 1", name: "", isPlayerAlive: true)
    
    
    var player2 = Player(defaultName: "Joueur 2", name: "", isPlayerAlive: true)
    
    
    var numberOfRounds = 0
    
    
    var startingPlayer = Int(arc4random_uniform(2))
    
    
    var playersName = [String]()
    
    
    func createPlayerName(player: Player) {
        
        while player.name.isEmpty { // Boucle qui tourne tant que le joueur n'as pas de nom
            
            print("\n\(player.defaultName), choisissez un nom :")
            
            let choosenPlayerName = readLineWithoutOptional() // Récupère le nom entré par le joueur
            
            let nameChoice = choosenPlayerName.trimmingCharacters(in: .whitespaces)
            
            if choosenPlayerName.count < 4 { // Vérifie la chaine de caractère rentré est inférieur à 4 caractères
                
                print("Votre nom dois contenir au moins 4 caractères.")
                
            } else if playersName.contains(nameChoice) { // Vérifie si le nom est déja pris
                
                print("Ce nom est déjà pris.")
                
            } else {
                
                player.name = nameChoice // On initialise la variable du nom par le nom entré
                
                playersName.append(nameChoice) // Ajout de ce nom dans le tableau de tout les noms
                
            }
        }
        
    }
    
    
    
    private func attackingPlayer() -> Player { // Définis qui attaquera en premier, au hasard
        
        if (numberOfRounds + startingPlayer) % 2 == 0 {
            
            
            return player1
            
        } else {
            
            
            return player2
            
        }
    }
    
    private func sufferingPlayer() -> Player { // Définis qui defendra, a contrario de l'attaquant
        
        if (numberOfRounds + startingPlayer) % 2 == 0 {
            
            return player2
            
        } else {
            
            return player1
            
        }
    }
    
    
    private func fight() {
        
        while player1.isTeamAlive() && player2.isTeamAlive() {
            
            var attacker = attackingPlayer() // Définis l'attaquant
            
            var defender = sufferingPlayer() // Définis le défenseur
            
            print("\n\(attacker.name), choisissez le personnage que vous souhaitez utiliser:")
            
            let attackingCharacter: Character = attacker.actionChoice() // Selection du personnage dans l'équipe
            
            Player.randomWeaponMayAppear(for: attackingCharacter)
            
            if attackingCharacter.isAlive == false { // Si le personnage séléctionné est mort, impossible de le prendre
                
                print("Ce personnage est mort ☠️, vous ne pouvez plus l'utiliser.")
                
                
            } else {
                
                
                print("Que voulez vous faire : Attaquer (attack) ou Soigner (heal) ?") // Si le personnage n'est pas mort on demande l'action voulu
                
                let action = readLineWithoutOptional()
                
                switch action {
                
                case "attack":
                    
                    print("\nQuel personnage de l'équipe adverse voulez vous attaquer ?")
                    
                    let characterToAttack = defender.actionChoice() // Selection du personnage a attaqué
                    
                    if characterToAttack.isAlive == false { // Vérification de la mort du personnage selectionné
                        
                        print("Vous ne pouvez pas attaquer un personnage déjà mort.\n")
                        
                        
                    } else {
                        
                        attackingCharacter.attack(sufferingCharacter: characterToAttack) // Si tout est bon, on attaque
                        
                        print("\n\(characterToAttack.name) a subis \(attackingCharacter.weapon.damage) de dégâts.\n")
                        
                        if characterToAttack.isAlive == false { // Si le personnage meurt pendant l'attaque, on affiche un message
                            
                            print("\(characterToAttack.name) est mort suite a cette attaque ! ☠️\n")
                            
                        }
                        
                        swap(&attacker, &defender) // On échange les roles
                        
                        numberOfRounds += 1 // Fin du round
                        
                    }
                    
                case "heal":
                    
                    print("\nQuel personnage de votre équipe voulez vous soigner ?")
                    
                    let characterToHeal = attacker.actionChoice() // Selection du personnage à soigner dans sa propre équipe
                    
                    if characterToHeal.isAlive == false { // On vérifie si le personnage est mort
                        
                        print("Vous ne pouvez pas soigner un allié mort.\n")
                        
                    } else {
                        
                        attackingCharacter.heal(healedCharacter: characterToHeal) // Si tout vas bien, on soigne le personnage choisi
                        
                        print("\n\(attackingCharacter.name) a soigné son allié \(characterToHeal.name) de \(attackingCharacter.weapon.heal) points de vie.\n")
                        
                        swap(&attacker, &defender) // On échange les roles
                        
                        numberOfRounds += 1 // Fin du round
                        
                    }
                    
                default:
                    
                    print("❌ Je n'ai pas compris, veuillez reessayer.\n")
                }
            }
            
            
        }
        
        if player1.isTeamAlive() == true {
            
            showWinner(player1)
            
        } else {
            
            showWinner(player2)
            
        }
        
        func showWinner(_ player: Player) {
            
            print("Attendez...\n")
            
            sleep(1)
            
            print("Nous avons un gagnant !\n")
            
            sleep(1)
            
            print("---------------------------------------\n"
                    
                    + "Bien joué 👑\(player.name)👑!\nTu gagnes la partie !💪\n\n ")
            // ToDo: Créer une fonction avec en paramètre Player
            
            end(player1) // Affichage des statistiques des personnages de l'équipe 1 : Nom, points de vie restants
            end(player2) // Affichage des statistiques des personnages de l'équipe 2 : Nom, points de vie restants
            
        }
        
        
    }
    
    func start() {
        
        print("Bienvenue sur un jeu vidéo en ligne de commande !\n")
        
        sleep(1)
        
        print("C'est une jeu en tour par tour."
                + "\nTout d'abord, chaque joueur choisira son nom et ceux de leurs personnages"
                + "\nQuand tout est prêt, faites place au combat !"
                + "\nLe dernier joueur avec son équipe en vie remporte la partie.")
        
        sleep(1)
        
        print("\nDémarrer la partie ? oui/non")
        
        let startGameOrNo = readLineWithoutOptional()
        
        switch startGameOrNo {
        
        case "oui":
            
            print("\nC'est parti !")
            
            sleep(1)
            
            createPlayerName(player: player1) // Appel de la fonction pour nommé le joueur 1
            
            createPlayerName(player: player2) // Appel de la fonction pour nommé le joueur 2
            
            print("\n\n")
            
            player1.characterSelection() // Appel de la fonction pour choisir 3 personnages pour l'équipe du joueur 1
            
            print("\n\n")
            
            player2.characterSelection() // Appel de la fonction pour choisir 3 personnages pour l'équipe du joueur 2
            
            fight() // Début du combat
        
        
        case "non":
            
            print("C'est dommage..")
            
            sleep(1)
            
            break
            
        default:
            
            print("Je n'ai pas compris")
            self.start()
        }
        
    }
    
    private func end(_ player: Player) { // Fin de la partie, affichage des statistiques des personnages en vie ou mort.
        
        print("La partie à durée \(numberOfRounds) tours.\n\n")
        
        print("Voici l'équipe de \(player.name) après le combat:\n")
        
        for character in player.characters {
            
            if character.isAlive == false {
                
                print("\(character.name) est mort au combat.. ☠️\n")
                
            } else {
                
                print("\(character.name) est toujours debout avec \(character.healthPoints) points de vie\n")
                
            }
        }
    }
}

// TODO: crée un fonction pour les textes du début.
// Bien tester tout les cas pour les prendre en compte
