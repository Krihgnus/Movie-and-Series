import Foundation
import UIKit

extension UIView {
    func setGradientBackground() {
        
        let colorGray = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor
        let colorWhite =  UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorGray, colorWhite, colorWhite, colorGray]
        gradientLayer.locations = [0.0, 0.2, 0.7, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.layer.addSublayer(gradientLayer)
        
    }
}
