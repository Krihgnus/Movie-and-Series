import Foundation
import UIKit

class ActionButtonExplore: UIButton {
     @IBAction func action(_ sender: UIButton) {
        self.buttonWithRadius()
        let tabBarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC")
        //present(tabBarViewController, animated: true, completion: nil)
    }
}
