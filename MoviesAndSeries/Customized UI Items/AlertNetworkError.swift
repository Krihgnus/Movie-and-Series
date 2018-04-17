import Foundation
import UIKit

class AlertHelper {
    static func makeNetworkErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Network Error", message: "Ckeck your connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}

extension UIViewController {
    func presentNetworkErrorAlert() {
        present(AlertHelper.makeNetworkErrorAlert(), animated: true)
    }
}


