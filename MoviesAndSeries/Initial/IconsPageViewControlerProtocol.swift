import Foundation
import UIKit

protocol IconsViewControllerDelegate: class {
    
    func InitialViewController(InitialViewController: InitialViewController, didUpdatePageCount count: Int)

    func InitialViewController(InitialViewController: InitialViewController, didUpdatePageIndex index: Int)
    
}
