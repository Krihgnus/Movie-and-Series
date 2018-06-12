import Foundation
import UIKit

protocol SeeAllButtonClicked: class {
    func seeAllClicked()
}

class SeeAllView: UIView {
    weak var delegate: SeeAllButtonClicked?
    
    @IBAction func seeAllButton(_ sender: UIButton) {
        delegate?.seeAllClicked()
    }
    
}
