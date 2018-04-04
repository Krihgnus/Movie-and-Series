import Foundation
import UIKit

class ButtonExploreCollection: UIViewController {
    let tabBarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC")
    
    @IBAction func action(_ sender: UIButton) {
        present(tabBarViewController, animated: true, completion: nil)
    }
}
