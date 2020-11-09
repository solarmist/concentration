//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Joshua Olson on 11/11/19.
//  Copyright © 2019 solarmist. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    var themes = [  // Each of these must be at least 8 emoji long
        "halloween": "🦇😱🙀😈🎃👻🍭🍬💀👺👽🕸🤖🧛🏻",
        "food": "🍎🥑🍠🥞🍕🥪🌮🍖🥝🥗🌭🍜🍚🍙🍟",
        "faces": "😀☺️😍😭🥶😡🤢🥴🤑🤐😵😱",
        "animals": "🐥🐒🐷🐹🐭🐶🐨🐸🐍🦀🐡🦐🦂🕷",
        "flags": "🇦🇽🇧🇩🇦🇮🇦🇶🇨🇦🇨🇻🇵🇫🇫🇴🇯🇵🇮🇩🇱🇧🇰🇵🇳🇴🇹🇿🇺🇸🇹🇴🇻🇳🇬🇧",
        "activities": "🤸🏋️🧘🤽🏊🏄🏌️🤾🚴🚣🧗"
    ]

    override func awakeFromNib() {
        //TODO: How can I not have to map these to each language individually?
        themes["ハロウィン"] = themes["halloween"]
        themes["食べ物"] = themes["food"]
        themes["顔"] = themes["faces"]
        themes["動物"] = themes["animals"]
        themes["旗"] = themes["flags"]
        themes["活動"] = themes["activities"]

        splitViewController?.delegate = self
    }

    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let concentrationVC = secondaryViewController as? ConcentrationViewController,
           concentrationVC.theme == nil {
            return true // I did not collapse this for you.
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
