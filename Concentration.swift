//
//  Concentration.swift
//  Concentration
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private(set) lazy var unmatchedCardsRemaining = cards.count
    private(set) var flipCount = 0

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices where cards[index].isFaceUp {
                if foundIndex == nil {
                    foundIndex = index
                } else {
                    return nil
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    func chooseCard(at index: Int) {
        if cards[index].isMatched { return }
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards.")
        flipCount += 1
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                unmatchedCardsRemaining -= 2
            }
            cards[index].isFaceUp = true
        } else {  // Two cards are face up
            indexOfOneAndOnlyFaceUpCard = index
        }
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0,
               "Concentration.chooseCard(at: \(numberOfPairsOfCards)): Need at least one pair of cards.")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }

}
