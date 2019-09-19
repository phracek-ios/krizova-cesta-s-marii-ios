//
//  CrossTabViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 17/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CrossTabViewController: ButtonBarPagerTabStripViewController {

    fileprivate var stationsStructure: StationsStructure?
    var mode: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == 0 {
            title = "Křížová cesta"
        } else {
            title = "Stabat Mater"
        }
        setupPagerTabBar()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        super.viewDidLoad()
    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var controllers: [UIViewController] = []
        
        stationsStructure = StationsDataService.shared.stationsStructure
        guard let stationsStructure = stationsStructure else { return [] }

        if mode == 0 {
            for i in 0..<16 {
                let vc = R.storyboard.main.childCrossTab()!
                let station = stationsStructure.station[i]
                vc.pagerTabTitle = "\(station.name)".uppercased()
                vc.pageContent = station.text
                vc.pager = i
                vc.mode = 0
                controllers.append(vc)
            }
        } else {
            let czech = R.storyboard.main.childCrossTab()!
            czech.pagerTabTitle = "Česky"
            czech.pager = 0
            czech.mode = 1
            let latin = R.storyboard.main.childCrossTab()!
            latin.pagerTabTitle = "Latinsky"
            latin.pager = 1
            latin.mode = 1
            controllers.append(czech)
            controllers.append(latin)
        }
        
        return controllers
    }

}

// MARK: - Private
private extension CrossTabViewController {
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
