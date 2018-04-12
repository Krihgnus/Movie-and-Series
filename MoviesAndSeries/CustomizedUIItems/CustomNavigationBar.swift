import Foundation
import UIKit

//Classe que altera o tipo da Status Bar
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
