import Foundation
import UIKit

class DiscoverTableViewCell: UITableViewCell {
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seeAllButtonOutlet: UIButton!
    
    weak var delegate: SeeAllButtonClicked?
    
    @IBAction func seeAllButton(_ sender: UIButton) {
        switch topicLabel.text {
        case "Most Popular":
            delegate?.seeAllClicked(index: 0)
        case "Most Recent":
            delegate?.seeAllClicked(index: 1)
        case "Comming Soon":
            delegate?.seeAllClicked(index: 2)
        default:
            break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        topicLabel.text = nil
    }

}
