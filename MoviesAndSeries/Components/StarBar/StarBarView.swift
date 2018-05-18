import Foundation
import UIKit

enum StarBarType {
    case noEvaluate
    case evaluate
}

var starBarCurrentScreen: StarBarType!

private var imageOn: UIImage = UIImage(imageLiteralResourceName: "starOn")
private var imageOff: UIImage = UIImage(imageLiteralResourceName: "starOff")

class StarBarView: UIView {
    
    @IBOutlet var stars: [UIButton]!
    var filledStars: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fillStars(1)
        stars.forEach { (button) in button.adjustsImageWhenHighlighted = false }
    }
    
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
        
        print("VALUE - \(value)")
        
//        let realIndex = value - 1
        
//        for (index, button) in stars.enumerated() {
//            if realIndex <= index {
//                DispatchQueue.main.async { button.setBackgroundImage(imageOff, for: .normal) }
//            } else {
//                DispatchQueue.main.async { button.setBackgroundImage(imageOn, for: .normal) }
//            }
//        }
        
        var idx = 0
        stars.forEach { (button) in
            if value > idx {
                DispatchQueue.main.async { button.setBackgroundImage(imageOn, for: .normal) }
            } else {
                DispatchQueue.main.async { button.setBackgroundImage(imageOff, for: .normal) }
            }
            idx += 1
        }
        
//        for (index, button) in stars.enumerated() {
//
//            if value > index {
//                DispatchQueue.main.async { button.setBackgroundImage(imageOn, for: .normal) }
//            } else {
//                DispatchQueue.main.async { button.setBackgroundImage(imageOff, for: .normal) }
//            }
//
//        }
        
//        filledStars = value
        
    }
    
}
