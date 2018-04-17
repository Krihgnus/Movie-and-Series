import Foundation
import UIKit

class NetworkError: UIAlertController {
    static let sharedAlertNetworkError = NetworkError()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Network Error"
        self.message = "Check your connection and try again"
        self.preferredStyle = UIAlertControllerStyle.default
        self.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    }
}
