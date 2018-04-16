import Foundation
import UIKit

class TesteViewController: UIViewController {
    @IBOutlet weak var imageTeste: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTeste.image = UIImage(imageLiteralResourceName: "Star Off")
    }
    
}
