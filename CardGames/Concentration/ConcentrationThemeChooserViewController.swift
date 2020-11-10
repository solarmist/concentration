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
        if let concentrationVC = secondaryViewController as? ConcentrationViewController,
           concentrationVC.theme == nil {
            return true // I did not collapse this for you.
        }
        return false
    }

    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    private var splitViewDetailConcentrationVC: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Theme", comment: "Title for the theme choose")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let theme = themes[identifier.lowercased()] else {
            return
        }
        print("themeName: \(identifier)")

        if let concentrationVC = segue.destination.contents as? ConcentrationViewController {
            print("Setting theme")
            concentrationVC.theme = theme
            lastSeguedToConcentrationViewController = concentrationVC
        }
    }
}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        }
        return self
    }
}
