//
//  BaseTableViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 13/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupNoTitleBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
