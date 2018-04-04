import Foundation
import UIKit

class IconesPageViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let InitialViewController = segue.destination as? InitialViewController {
            InitialViewController.initialDelegate = self
        }
    }
}

extension IconesPageViewController: IconsViewControllerDelegate {
    
    func InitialViewController(InitialViewController: InitialViewController, didUpdatePageCount count: Int) {
        self.pageControl.numberOfPages = count
    }
    
    func InitialViewController(InitialViewController: InitialViewController, didUpdatePageIndex index: Int) {
            self.pageControl.currentPage = index
    }
    
}
