//
//  StabatMaterViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 04/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import BonMot

class StabatMaterViewController: ButtonBarPagerTabStripViewController {

    fileprivate var stabatStructure: StabatMaterStructure?
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        setupPagerTabBar()
        super.viewDidLoad()

    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        stabatStructure = StabatMaterDataService.shared.stabatMaterStructure
        let czech = R.storyboard.main.childStabatMater()!
        czech.pagerTabTitle = "Česky2"
        print(stabatStructure?.czech)
        czech.childMaterLabel?.attributedText = generateContent(text: stabatStructure!.czech)
        let latin = R.storyboard.main.childStabatMater()!
        latin.pagerTabTitle = "Latinsky"
        latin.childMaterLabel?.attributedText = generateContent(text: stabatStructure!.latin)

        return [czech, latin]
    }

}

// MARK: - Private
private extension StabatMaterViewController {
    func setupPagerTabBar() {
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .white
        }
    }
}
