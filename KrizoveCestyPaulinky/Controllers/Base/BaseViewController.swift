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
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
}
