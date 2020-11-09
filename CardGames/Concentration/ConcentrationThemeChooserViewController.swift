//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Joshua Olson on 11/11/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    let themes = [  // Each of these must be at least 8 emoji long
        "halloween": "🦇😱🙀😈🎃👻🍭🍬💀👺👽🕸🤖🧛🏻",
        "food": "🍎🥑🍠🥞🍕🥪🌮🍖🥝🥗🌭🍜🍚🍙🍟",
        "faces": "😀☺️😍😭🥶😡🤢🥴🤑🤐😵😱",
        "animals": "🐥🐒🐷🐹🐭🐶🐨🐸🐍🦀🐡🦐🦂🕷",
        "flags": "🇦🇽🇧🇩🇦🇮🇦🇶🇨🇦🇨🇻🇵🇫🇫🇴🇯🇵🇮🇩🇱🇧🇰🇵🇳🇴🇹🇿🇺🇸🇹🇴🇻🇳🇬🇧",
        "activities": "🤸🏋️🧘🤽🏊🏄🏌️🤾🚴🚣🧗"
    ]

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }

    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true // I did not collapse this for you.
            }
        }
        return false
    }
    // MARK: - Navigation

    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    @IBAction func changeTheme(_ sender: Any) {
        guard let themeName = (sender as? UIButton)?.currentTitle,
              let theme = themes[themeName.lowercased()] else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
            return
        }

        if let cvc = splitViewDetailConcentrationVC {
            cvc.theme = theme
        } else if let cvc = lastSeguedToConcentrationViewController {
            navigationController?.pushViewController(cvc, animated: true)
            cvc.theme = theme
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }

    private var splitViewDetailConcentrationVC: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName.lowercased()] {
                print("themeName: \(theme)")
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
}
