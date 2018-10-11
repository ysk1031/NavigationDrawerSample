//
//  FirstContentViewController.swift
//  NavigationDrawerSample
//
//  Created by 青野雄介 on 2018/10/11.
//  Copyright © 2018 青野雄介. All rights reserved.
//

import UIKit

protocol FirstContentViewControllerDelegate: class {
    func openNavigationDrawer()
    func closeNavigationDrawer()
}

class FirstContentViewController: UIViewController {
    
    weak var delegate: FirstContentViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func drawerButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.openNavigationDrawer()
    }
}
