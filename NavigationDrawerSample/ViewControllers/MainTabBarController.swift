//
//  MainTabBarController.swift
//  NavigationDrawerSample
//
//  Created by 青野雄介 on 2018/10/11.
//  Copyright © 2018 青野雄介. All rights reserved.
//

import UIKit

protocol MainTabBarControllerDelegate: class {
    func tapOverlay()
}

class MainTabBarController: UITabBarController {
    
    private let overlayTag = 1
    
    weak var customDelegate: MainTabBarControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addOverlay() {
        if view.viewWithTag(overlayTag) != nil {
            return
        }
        let overlay = UIView(frame: view.bounds)
        overlay.tag = overlayTag
        overlay.backgroundColor = .black
        overlay.alpha = 0
        view.addSubview(overlay)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.overlayTapped(sender:)))
        overlay.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setOverlayAlpha(_ alpha: CGFloat) {
        guard let overlay = view.viewWithTag(overlayTag) else { return }
        overlay.alpha = alpha
    }
    
    func removeOverlay() {
        guard let overlay = view.viewWithTag(overlayTag) else { return }
        overlay.removeFromSuperview()
    }
    
    @objc private func overlayTapped(sender: UITapGestureRecognizer) {
        customDelegate?.tapOverlay()
    }
}
