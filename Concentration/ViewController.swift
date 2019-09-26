//
//  ViewController.swift
//  Concentration
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    @IBOutlet private weak var winLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.layer.cornerRadius = 20
        winLabel.layer.cornerRadius = 20
        newGameButton.clipsToBounds = true
        newGameButton.isHidden = true
        newGameButton.isEnabled = false
        winLabel.isHidden = true
    }

    @IBAction private func touchNewGame(_ sender: UIButton) {
        // Start a new game
        print("Staring a new game")
        emojiChoices.shuffle()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        newGameButton.isHidden = true
        newGameButton.isEnabled = false
        winLabel.isHidden = true

        updateViewFromModel()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            print(cardNumber)
        }
        updateViewFromModel()
        if game.unmatchedCardsRemaining == 0 {
            winLabel.isHidden = false
            newGameButton.isHidden = false
            newGameButton.isEnabled = true
        }
    }

    func updateViewFromModel() {
        flipCountLabel.text = "\(game.flipCount)"
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFaceUp {
                print("Showing Card \(index)")
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cardButtons[index].isEnabled = false
            } else {
                cardButtons[index].setTitle("", for: UIControl.State.normal)
                cardButtons[index].backgroundColor = card.isMatched ?#colorLiteral(red: 0.6910327673, green: 0.6910327673, blue: 0.6910327673, alpha: 0): #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                cardButtons[index].isEnabled = card.isMatched ? false : true
            }
        }
    }

    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "💀",  // 10
                                "👺", "👽", "🕸", "🤖", "🧛🏻‍♀️"]

    func emoji(for card: Card) -> String {
        print(emojiChoices[card.identifier % emojiChoices.count])
        return emojiChoices[card.identifier % emojiChoices.count]
    }
}
