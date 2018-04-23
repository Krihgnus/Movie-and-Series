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
