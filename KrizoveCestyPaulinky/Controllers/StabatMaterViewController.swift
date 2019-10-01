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
        title = "Stabat Mater"
        setupPagerTabBar()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let czech = R.storyboard.main.childStabatMater()!
        czech.pagerTabTitle = "Česky"
        czech.pager = 0
        let latin = R.storyboard.main.childStabatMater()!
        latin.pagerTabTitle = "Latinsky"
        latin.pager = 1

        return [czech, latin]
    }

}

// MARK: - Private
private extension StabatMaterViewController {
    func setupPagerTabBar() {
        settings.style.buttonBarBackgroundColor = UIColor.KrizovaCestaSMarii.mainColor()
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor.KrizovaCestaSMarii.yellowColor()
        settings.style.selectedBarHeight = 4
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarHeight = 44
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.attributedText = oldCell?.label.text?.styled(with: Styles.tabInActive)
            newCell?.label.attributedText = newCell?.label.text?.styled(with: Styles.tabActive)
        }
    }
}
