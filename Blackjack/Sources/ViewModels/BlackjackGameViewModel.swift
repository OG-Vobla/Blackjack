//
//  BlackjackGameViewModel.swift
//  Blackjack
//
//  Created by Радэль Зубаиров on 13.01.2025.
//

import SwiftUI
import Combine

class BlackjackGameViewModel: ObservableObject {
    @Published var playerCards: [CardModel] = []
    @Published var dealerCards: [CardModel] = []
    @Published var playerScore: Int = 0
    @Published var dealerScore: Int = 0
    @Published var gameOver: Bool = false
    @Published var finalMessage: String = ""
    @Published var gameStatus: GameStatus = .playing

    private var deck: [CardModel] = []
    
    // Инициализация новой игры
    init() {
    }

    func resetGame() {
        deck = CardDeck().shuffle() // Убедитесь, что у вас есть реализация колоды
        playerCards.removeAll()
        dealerCards.removeAll()
        playerScore = 0
        dealerScore = 0
        gameStatus = .playing
        dealInitialCards()
    }

    private func dealInitialCards() {
        while playerCards.count < 2 {
            playerCards.append(drawCard())
        }
        
        while dealerCards.count < 2 {
            dealerCards.append(drawCard())
        }
        
        calculateScores()
        checkForEndGame()
    }

    private func drawCard() -> CardModel {
        guard !deck.isEmpty else { return CardModel(suit: .spades, value: 1, cardImage: "1_of_clubs", cardValue: .num1) } // Вернуться, если колода пустая
        return deck.removeFirst()
    }
    
    private func calculateScores() {
        playerScore = calculateScore(for: playerCards)
        dealerScore = calculateScore(for: dealerCards)
    }

    private func calculateScore(for cards: [CardModel]) -> Int {
        var score = 0
        var aces = 0

        for card in cards {
            score += card.value
            if card.cardValue == .numA {
                aces += 1
            }
        }

        // Обрабатывать тузы
        while score > 21 && aces > 0 {
            score -= 10
            aces -= 1
        }

        return score
    }

    func hit() {
        guard gameStatus == .playing else { return }
        playerCards.append(drawCard())
        calculateScores()
        checkForEndGame()
    }
    
    func double() {
        hit()
    }

    func stand() {
        gameStatus = .dealerTurn
        dealerPlay()
    }

    private func dealerPlay() {
        while dealerScore < 17 && gameStatus == .dealerTurn {
            dealerCards.append(drawCard())
            calculateScores()
        }
        checkForEndGame()
    }

    private func checkForEndGame() {
        if playerScore > 21 {
            gameStatus = .lost
            finalMessage = "You lost("
            gameOver = true
        } else if dealerScore > 21 || playerScore == 21 {
            gameStatus = .won
            finalMessage = "You won)"
            gameOver = true
        } else if dealerScore >= 17 {
            if playerScore > dealerScore {
                gameStatus = .won
                finalMessage = "You won)"
            } else if playerScore < dealerScore {
                gameStatus = .lost
                finalMessage = "You lost("
            } else if playerScore == dealerScore{
                gameStatus = .draw
                finalMessage = "Draw..."
            }
            gameOver = true
        }
        else {
            gameOver = false
        }
    }

    enum GameStatus {
        case playing, dealerTurn, won, lost, draw
    }
}

// Пример реализации колоды карт
struct CardDeck {
    let cards: [CardModel]
    
    init() {
        cards = Constants.allCards
    }
    
    func shuffle() -> [CardModel] {
        cards.shuffled()
    }
}
