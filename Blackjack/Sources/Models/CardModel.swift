//
//  CardModel.swift
//  Blackjack
//
//  Created by Радэль Зубаиров on 23.12.2024.
//

struct CardModel {
    var suit: CardsSuits
    var value: Int
    var cardImage: String
    var cardValue: CardsValues
}

enum CardsSuits: String {
    case hearts
    case diamonds
    case clubs
    case spades
}

enum CardsValues {
    case num1, num2, num3, num4, num5, num6, num7, num8, num9, num10, numJ, numQ, numK, numA
}
