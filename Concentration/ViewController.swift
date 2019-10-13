//
//  ViewController.swift
//  Concentration
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import UIKit

let emojiThemes = [  // Each of these must be at least 8 emoji long
    "halloween": "🦇😱🙀😈🎃👻🍭🍬🍎💀👺👽🕸🤖🧛🏻‍♀️",
    "food": "🍎🥑🍠🥞🍕🥪🌮🍖🥝🥗🌭🍜🍚🍙🍟",
    "faces": "😀☺️😍😭🥶😡🤢🥴🤑🤐😵😱",
    "animals": "🐥🐒🐷🐹🐭🐶🐨🐸🐍🦀🐡🦐🦂🕷",
    "flags": "🇦🇽🇧🇩🇦🇮🇦🇶🇨🇦🇨🇻🇵🇫🇫🇴🇯🇵🇮🇩🇱🇧🇰🇵🇳🇴🇹🇿🇺🇸🇹🇴🇻🇳🇬🇧",
    "activities": "🤸‍♀️🏋️‍♀️🧘‍♀️🤽‍♀️🏊‍♀️🏄‍♀️🏌️‍♀️🤾‍♂️🚴‍♀️🚣‍♀️🧗‍♂️"
]


class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    @IBOutlet weak var flipsLabel: UILabel! {
        didSet {
            updateLabel()
        }
    }
    @IBOutlet private weak var winLabel: UILabel! {
        didSet {
            updateLabel()
        }
    }
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateLabel()
        }
    }
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!

    private func updateLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: flipCountLabel.text!, attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
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
        // These are statically defined so forcefully accessing the values is fine.
        currentTheme = Array(emojiThemes.keys).randomElement()!
        emojiChoices = ""
        emoji = [Card: String]()
        print("Staring a new game with theme \(currentTheme)")
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
        flipCountLabel.text = "\(game.score)"
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

    var currentTheme: String = Array(emojiThemes.keys).randomElement()!
    private var emojiChoices: String = ""
    private var emoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        if emojiChoices.count == 0, emoji.count == 0 {
            emojiChoices = String(emojiThemes[currentTheme]!.shuffled())
        }

        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }

        print(emoji[card] ?? "?")
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
