import Foundation
import UIKit

class AlertHelper {
    static func makeNetworkErrorAlert() -> UIAlertController {
        let alertNetworkError = UIAlertController(title: "Network Error", message: "Ckeck your connection and try again.", preferredStyle: .alert)
        alertNetworkError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertNetworkError
    }
}

extension UIViewController {
    func presentNetworkErrorAlert() {
        present(AlertHelper.makeNetworkErrorAlert(), animated: true)
    }
}


