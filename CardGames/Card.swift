//
//  Card.swift
//  Concentration
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import Foundation

// This is a face for when all you need is a unique value per card for mapping
struct GenericFace: Equatable, Hashable, CustomStringConvertible {
    private static var identifierFactory = 0
    var identifier: Int
    var description: String {"\(identifier)"}

    init() {
       self.identifier = GenericFace.getUniqueIdentifier()
    }

    private static func getUniqueIdentifier() -> Int {
         identifierFactory += 1
         return identifierFactory
     }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

}

let itemsInCategory = 3

struct SetCardFace: Equatable, Hashable, CustomStringConvertible {
    enum Shading: String, CaseIterable {
        case empty, stripping, fill
    }
    enum Color: String, CaseIterable {
        case red, green, purple
    }
    enum Shape: String, CaseIterable {
        case squiggle, oval, diamond
    }

    let shading: Shading, color: Color, shape: Shape
    let numShapes: Int

    var description: String {"{Shape: \(shape), Shading: \(shading), Color: \(color), numShapes: \(numShapes)}"}
}

struct Card<FaceType: Equatable & Hashable & CustomStringConvertible>: Equatable, Hashable, CustomStringConvertible {
    var description: String {faceValue.description}

    var faceValue: FaceType
    var isFaceUp = false
    var selected = false
    var indicesSeen = Set<Int>()

    func hash(into hasher: inout Hasher) {
        faceValue.hash(into: &hasher)
    }

    static func == (lhs: Card<FaceType>, rhs: Card<FaceType>) -> Bool {
        lhs.faceValue == rhs.faceValue
    }

}
