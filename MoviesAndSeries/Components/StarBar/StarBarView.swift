import Foundation
import UIKit

enum StarBarType {
    
    case noEvaluate
    case evaluate
    
}

var starBarCurrentScreen: StarBarType!

private var imageOn: UIImage = UIImage(imageLiteralResourceName: "star-on")
private var imageOff: UIImage = UIImage(imageLiteralResourceName: "star-off")

class StarBarView: UIView {
    
    @IBOutlet var stars: [UIButton]!
    
    @IBAction func star1(_ sender: UIButton) {
        
        if starBarCurrentScreen == .noEvaluate {
            
            return
            
        }
        
        fillStars(1)
        
    }
    
    @IBAction func star2(_ sender: UIButton) {
        
        if starBarCurrentScreen == .noEvaluate {
            
            return
            
        }
        
        fillStars(2)
        
    }
    
    @IBAction func star3(_ sender: UIButton) {
        
        if starBarCurrentScreen == .noEvaluate {
            
            return
        }
        
        fillStars(3)
        
    }
    
    @IBAction func star4(_ sender: UIButton) {
        
        if starBarCurrentScreen == .noEvaluate {
            
            return
            
        }
        
        fillStars(4)
        
    }
    
    @IBAction func star5(_ sender: UIButton) {
        
        if starBarCurrentScreen == .noEvaluate {
            
            return
            
        }
        
        fillStars(5)
        
    }
    
    func fillStars(_ value: Int ) {
        
        for (index, button) in stars.enumerated() {
            
            button.setImage(imageOff, for: .normal)
            
            if value > index {
                
                button.setImage(imageOn, for: .normal)
                
            }
            
        }

    }
    
}
