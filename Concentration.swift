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
    private(set) var score = 0

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    func chooseCard(at index: Int) {
        if cards[index].isMatched { return }
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)).")
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            if cards[matchIndex] == cards[index] {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                unmatchedCardsRemaining -= 2
                score += 2
            } else if cards[index].indicesSeen.contains(index),
                cards[matchIndex].indicesSeen.contains(matchIndex) {
                score -= 2
            } else if cards[index].indicesSeen.contains(index) || cards[matchIndex].indicesSeen.contains(matchIndex) {
                score -= 1
            }
            if !cards[matchIndex].indicesSeen.contains(matchIndex) {
                cards[matchIndex].indicesSeen.append(matchIndex)
            }
            if !cards[index].indicesSeen.contains(index) {
                cards[index].indicesSeen.append(index)
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
