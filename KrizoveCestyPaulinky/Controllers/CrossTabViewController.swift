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
    var modePaulOrMarrry: Int = 0
    var mode: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == 0 {
            title = "Křížová cesta s Marií"
        } else if mode == 1 {
            title = "Křížová cesta s Pavlem"
        } else if mode == 2 {
            title = "Stabat Mater"
        } else {
            title = "Modlitby z Paulínského modlitebníku"
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
                let station = stationsStructure.stationMaria[i]
                vc.pagerTabTitle = "\(station.name)".uppercased()
                vc.pageContent = station.text
                vc.pager = i
                vc.mode = mode
                controllers.append(vc)
            }
        } else if mode == 1 {
            for i in 0..<17 {
                let vc = R.storyboard.main.childCrossTab()!
                let station = stationsStructure.stationPaul[i]
                vc.pagerTabTitle = "\(station.name)".uppercased()
                vc.pageContent = station.text
                vc.pager = i
                vc.mode = mode
                controllers.append(vc)
            }
        } else if mode == 2 {
            let czech = R.storyboard.main.childCrossTab()!
            czech.pagerTabTitle = "Česky"
            czech.pager = 0
            czech.mode = 2
            let latin = R.storyboard.main.childCrossTab()!
            latin.pagerTabTitle = "Latinsky"
            latin.pager = 1
            latin.mode = mode
            controllers.append(czech)
            controllers.append(latin)
        } else {
            for i in 0..<3 {
                let vc = R.storyboard.main.childCrossTab()!
                let prayer = stationsStructure.prayer[i]
                vc.pagerTabTitle = "\(prayer.name)".uppercased()
                vc.pageContent = prayer.text
                vc.pager = i
                vc.mode = 1
                controllers.append(vc)
            }
        }
        return controllers
    }

}

// MARK: - Private
private extension CrossTabViewController {
    func setupPagerTabBar() {
        if mode == 0 {
            settings.style.buttonBarBackgroundColor = UIColor.KrizovaCestaSMarii.mainColor()
        }
        else {
            settings.style.buttonBarBackgroundColor = UIColor.KrizovaCestaSMarii.mainColorP()
        }
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
