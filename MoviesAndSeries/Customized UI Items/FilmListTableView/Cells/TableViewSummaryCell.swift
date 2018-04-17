import Foundation
import UIKit

class CellSummaryType: UITableViewCell {
    static let identifier = "summaryCell"
    @IBOutlet weak var bornData: UILabel!
    @IBOutlet weak var artistHistory: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bornData.text = nil
        artistHistory.text = nil
    }
    
    func configure(_ artista: [String]) { //FUNC CONFIGURE(_ ARTISTA: OBJ ARTISTA) { }
        bornData.text = artista[0] //BORNDATA.TEXT = ARTISTA.BORNDATA (OU SEMELHANTE)
        artistHistory.text = artista[1] //ARTISTDESCRIPTION.TEXT = ARTISTA.TEXTDESCRIPTION (OU SEMELHANTE)
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        self.selectionStyle = .none
    }
}
