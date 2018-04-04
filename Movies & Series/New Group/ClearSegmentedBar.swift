import Foundation
import UIKit

extension UISegmentedControl {
    func clearSegmentedBar() {
        self.removeAllSegments()
        self.selectedSegmentIndex = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor: UIColor.lightGray], for: .normal)
        self.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)], for: .selected)
        
    }
}
