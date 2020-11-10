//
//  ViewController.swift
//  Concentration
//
//  Created by Joshua Olson on 9/7/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
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
            .strokeWidth: 5.0
//            .strokeColor: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: flipCountLabel.text!, attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if theme == nil {
            theme = "🦇😱🙀😈🎃👻🍭🍬🍎💀👺👽🕸🤖🧛🏻"  // Set the initial theme
        }
        winLabel.layer.cornerRadius = 20
        winLabel.isHidden = true

        newGameButton.layer.cornerRadius = 20
        newGameButton.isHidden = true
        newGameButton.clipsToBounds = true
        newGameButton.isEnabled = false

        navigationItem.title = NSLocalizedString("Pick theme", comment: "This is the link back to the theme choose")
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

    }

    @IBAction private func touchNewGame(_ sender: UIButton) {
        // Start a new game
        // These are statically defined so forcefully accessing the values is fine.
        let formatString = NSLocalizedString("Starting a new game with theme %s",
                                             comment: "This is the name of the label")
        print(String.localizedStringWithFormat(formatString, theme ?? "??"))
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
        // Guard our code against being called during prepare
        guard cardButtons != nil else {
            print("Trying to update view before outlets are set")
            return
        }
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
                cardButtons[index].backgroundColor = game.matchedCards.contains(card) ?#colorLiteral(red: 0.6910327673, green: 0.6910327673, blue: 0.6910327673, alpha: 0): #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                cardButtons[index].isEnabled = game.matchedCards.contains(card) ? false : true
            }
        }
    }

    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }

    private var emojiChoices: String = ""
    private var emoji = [Card<GenericFace>: String]()

    private func emoji(for card: Card<GenericFace>) -> String {
        print("Emoji left: \(emojiChoices)")
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            print("\(card) not in emoji: Mapping to \(emojiChoices[randomStringIndex])")
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
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
