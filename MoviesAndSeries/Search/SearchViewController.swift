import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var resultsTableView: FilmList!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var bottomSegmentBarView: UIView!
    
    var movies: [Film] = []
    var series: [Serie] = []
    var genres: [String: URL] = [:]
    var artists: [Artist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupSegmentedBar()
        updateContent()
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.bottomSegmentBarView.frame.origin.x = (self.segmentBar.frame.width / 4) * CGFloat(self.segmentBar.selectedSegmentIndex)
        }
    }
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.layer.cornerRadius = 4
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        navigationController?.navigationBar.tintColor = UIColor(red: 2 / 255, green: 149 / 255, blue: 165 / 255, alpha: 100)
    }
    
    func setupSegmentedBar() {
        segmentBar.clearSegmentedBar()
        segmentBar.insertSegment(withTitle: "Movies", at: 0, animated: false)
        segmentBar.insertSegment(withTitle: "Series", at: 1, animated: false)
        segmentBar.insertSegment(withTitle: "Genres", at: 2, animated: false)
        segmentBar.insertSegment(withTitle: "Artists", at: 3, animated: false)
        segmentBar.selectedSegmentIndex = 0
        indexChanged(segmentBar)
    }
    
    func updateContent() {}

}
