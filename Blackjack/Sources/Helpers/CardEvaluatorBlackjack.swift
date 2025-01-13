//
//  CardEvaluatorBlackjack.swift
//  Blackjack
//
//  Created by Радэль Зубаиров on 13.01.2025.
//

class CardEvaluator {
    func calculateScore(for cards: [CardModel]) -> Int {
        var score = 0
        var aceCount = 0
        
        for card in cards {
            switch card.cardValue {
            case .numA:
                score += 11
                aceCount += 1
            default:
                score += card.value
            }
        }
        
        while score > 21 && aceCount > 0 {
            score -= 10
            aceCount -= 1
        }
        
        return score
    }
    
    func isBlackjack(for cards: [CardModel]) -> Bool {
        return cards.count == 2 && calculateScore(for: cards) == 21
    }
}
