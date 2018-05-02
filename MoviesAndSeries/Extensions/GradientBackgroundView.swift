import Foundation
import UIKit

enum GradientsType {
    
    case gray
    case white
    
}

extension UIView {
    
    func setGradientBackground(_ type: GradientsType) {
        
        let colorGray = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor
        let colorClear = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.0).cgColor
        let colorWhite = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()

        if type == .gray {
            
            gradientLayer.colors = [colorGray, colorClear, colorClear, colorGray]
            gradientLayer.locations = [0.0, 0.12, 0.6, 1.0]
            
        } else {
            
            gradientLayer.colors = [colorClear, colorWhite]
            gradientLayer.locations = [0.0, 0.9]
            
        }
        
        gradientLayer.frame = self.bounds
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.layer.addSublayer(gradientLayer)
        
    }
    
}
