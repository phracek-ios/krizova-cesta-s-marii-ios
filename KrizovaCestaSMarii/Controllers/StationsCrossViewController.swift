//
//  StationsCrossViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 17/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class StationsCrossViewController: ButtonBarPagerTabStripViewController {

    fileprivate var stationsStructure: StationsStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Křížová cesta"
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

        for i in 0..<15 {
            let vc = R.storyboard.main.childStationsCross()!
            let station = stationsStructure.station[i]
            vc.pagerTabTitle = "\(station.name)".uppercased()
            vc.pageContent = station.text
            vc.pager = i
            controllers.append(vc)
        }
        
        return controllers
    }

}

// MARK: - Private
private extension StationsCrossViewController {
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
