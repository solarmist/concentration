//
//  Card.swift
//  Concentration
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import Foundation

struct Card: Hashable {
    private static var identifierFactory = 0

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

}
