//
//  BaseViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 13/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNoTitleBackButton()
    }
    
    func setupNoTitleBackButton() {
        print("setup No")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
