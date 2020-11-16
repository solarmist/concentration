//
//  ConcentrationTests.swift
//  ConcentrationTests
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import XCTest
@testable import CardGames

class ConcentrationTests: XCTestCase {
    private var game: Concentration?

    override func setUp() {
        game = Concentration(numberOfPairsOfCards: 10)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        game = nil
    }

    // Ensure choosing an invalid index doesn't cause issues
    func testChooseCardBadIndex() {
        // Given
        XCTAssertEqual(game?.score, 0)
        // When
        game?.chooseCard(at: 99)
        // Then
        XCTAssertEqual(game?.score, 0)
    }

    func testMatchIncreasesScore() {
        // Given
        XCTAssertEqual(game?.score, 0)
        game?.chooseCard(at: 0)

        // When
        game?.chooseCard(at: 1)

        // Then
        XCTAssertEqual(game?.score, 2)
    }

    // A single failed match should not affect your score
    func testFailedMatch() {
        // Given
        XCTAssertEqual(game?.score, 0)
        // When
        // Failed match
        game?.chooseCard(at: 0)
        game?.chooseCard(at: 3)
        // Then
        XCTAssertEqual(game?.score, 0)
    }

    // One card is repeatedly chosen reducing the score
    func testRepeatedUnmatchedCardDecreasesScore() {
        // Given
        XCTAssertEqual(game?.score, 0)
        // Failed match
        game?.chooseCard(at: 0)
        game?.chooseCard(at: 3)

        // When
        game?.chooseCard(at: 0)
        game?.chooseCard(at: 5)

        // Then
        XCTAssertEqual(game?.score, -1)
    }

    // When a pair is incorrectly matched more than once multiple points are removed
    func testRepeatedFailedMatchDecreasesScore() {
        // Given
        XCTAssertEqual(game?.score, 0)
        // Failed match
        game?.chooseCard(at: 0)
        game?.chooseCard(at: 3)

        // When
        game?.chooseCard(at: 0)
        game?.chooseCard(at: 3)

        // Then
        XCTAssertEqual(game?.score, -2)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
