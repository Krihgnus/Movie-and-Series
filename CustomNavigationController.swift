//
//  CustomNavigationController.swift
//  Movies & Series
//
//  Created by Nodo Digital on 4/11/18.
//  Copyright © 2018 Nodo Digital. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    var overridenPreferredStatusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return overridenPreferredStatusBarStyle
    }

}
