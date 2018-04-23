import Foundation
import UIKit
import SDWebImage

class CategoryCell: UITableViewCell {
    
    static let identifier = "categoryCell"
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        categoryImage.image = nil
        categoryName.text = nil
        
    }
    
    func configure(name: String, image: URL) {//FUNC CONFIGURE(_ FILM: OBJ FILME) {
        
        self.selectionStyle = .none
        
        categoryName.text = name
        categoryImage.sd_setImage(with: image, completed: nil)
        
    }
    
}
