import Foundation
import UIKit

class ExploreCollectionViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    let tabBarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC")
    
    @IBAction func action(_ sender: UIButton) {
        present(tabBarViewController, animated: true, completion: nil)
    }
}
