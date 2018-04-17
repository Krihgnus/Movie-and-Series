import Foundation
import UIKit

class ButtonWithRadius: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
}

