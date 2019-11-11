//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Joshua Olson on 11/11/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [  // Each of these must be at least 8 emoji long
        "halloween": "🦇😱🙀😈🎃👻🍭🍬🍎💀👺👽🕸🤖🧛🏻",
        "food": "🍎🥑🍠🥞🍕🥪🌮🍖🥝🥗🌭🍜🍚🍙🍟",
        "faces": "😀☺️😍😭🥶😡🤢🥴🤑🤐😵😱",
        "animals": "🐥🐒🐷🐹🐭🐶🐨🐸🐍🦀🐡🦐🦂🕷",
        "flags": "🇦🇽🇧🇩🇦🇮🇦🇶🇨🇦🇨🇻🇵🇫🇫🇴🇯🇵🇮🇩🇱🇧🇰🇵🇳🇴🇹🇿🇺🇸🇹🇴🇻🇳🇬🇧",
        "activities": "🤸🏋️🧘🤽🏊🏄🏌️🤾🚴🚣🧗"
    ]
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName.lowercased()] {
                print("themeName: \(theme)")
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }
}
