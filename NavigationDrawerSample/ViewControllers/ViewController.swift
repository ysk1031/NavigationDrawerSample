//
//  ViewController.swift
//  NavigationDrawerSample
//
//  Created by 青野雄介 on 2018/10/11.
//  Copyright © 2018 青野雄介. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var navigationDrawerVc: UIViewController!
    private var mainTabBarVc: MainTabBarController!
    
    private var isNavigationDrawerOpen = false
    
    private let drawerRightSpace: CGFloat = 96
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add MainTabBarVc
        mainTabBarVc = UIStoryboard(name: "MainView", bundle: nil).instantiateInitialViewController() as? MainTabBarController
        addChild(mainTabBarVc)
        mainTabBarVc.view.frame = view.bounds
        view.addSubview(mainTabBarVc.view)
        mainTabBarVc.didMove(toParent: self)
        mainTabBarVc.customDelegate = self
        
        guard let firstContentNavigationVc = mainTabBarVc.viewControllers?.first as? UINavigationController,
            let firstContentVc = firstContentNavigationVc.viewControllers.first as? FirstContentViewController else
        {
            return
        }
        firstContentVc.delegate = self
        
        // Add NavigationDrawerVC
        navigationDrawerVc = UIStoryboard(name: "NavigationDrawer", bundle: nil).instantiateInitialViewController()!
        addChild(navigationDrawerVc)
        let navigationDrawerFrame = CGRect(x: -view.bounds.width + drawerRightSpace,
                                           y: 0,
                                           width: view.bounds.width - drawerRightSpace,
                                           height: view.bounds.height)
        navigationDrawerVc.view.frame = navigationDrawerFrame
        view.addSubview(navigationDrawerVc.view)
        navigationDrawerVc.didMove(toParent: self)
    }
}

extension ViewController: FirstContentViewControllerDelegate {
    func openNavigationDrawer() {
        if isNavigationDrawerOpen == true {
            return
        }
        
        isNavigationDrawerOpen = true
        mainTabBarVc.addOverlay()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.navigationDrawerVc.view.frame.origin.x = 0
            self.mainTabBarVc.view.frame.origin.x = self.view.bounds.width - self.drawerRightSpace
            self.mainTabBarVc.setOverlayAlpha(0.5)
        }
    }
    
    func closeNavigationDrawer() {
        if isNavigationDrawerOpen == false {
            return
        }
        
        isNavigationDrawerOpen = false
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                guard let self = self else { return }
                self.navigationDrawerVc.view.frame.origin.x = -self.view.bounds.width + self.drawerRightSpace
                self.mainTabBarVc.view.frame.origin.x = 0
                self.mainTabBarVc.setOverlayAlpha(0)
        }) { [weak self] _ in
            self?.mainTabBarVc.removeOverlay()
        }
    }
}

extension ViewController: MainTabBarControllerDelegate {
    func tapOverlay() {
        closeNavigationDrawer()
    }
}
