//
//  Card.swift
//  Concentration
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import Foundation

struct Card {
    private static var identifierFactory = 0

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
