import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var titleNavigationBarView: UIView!
    @IBOutlet weak var contentNavigationBar: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavigationBarView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        titleNavigationBarView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchBar.layer.cornerRadius = 4
        searchBar.placeholder = "Search"
        navigationController?.navigationBar.tintColor = UIColor(red: 2 / 255, green: 149 / 255, blue: 165 / 255, alpha: 100)
        
        contentNavigationBar.titleView = titleNavigationBarView
    }
}
