import Foundation
import UIKit

enum FilmDetailsBackColor {
    
    case white
    case blue
    
}

class MovieDetailsViewController: UIViewController {
    var backWithColor: FilmDetailsBackColor!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        let threePointsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 6))
        threePointsButton.setBackgroundImage(UIImage(imageLiteralResourceName: "threePointsIcon"), for: .normal)
        threePointsButton.setBackgroundImage(UIImage(imageLiteralResourceName: "threePointsIcon"), for: .highlighted)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: threePointsButton)
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(true)

        (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        
        if backWithColor == .white {
            
            navigationController?.navigationBar.tintColor = .white
            (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
            
        } else {
            
            navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
            (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
            
        }
        
    }
    
}

