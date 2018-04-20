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
    
    func configure(_ artista: Artist) {
        
        bornData.text = "\(artista.localNascimento["Cidade"] ?? "Unknown"), \(artista.localNascimento["Estado"] ?? "Unknown"), \(artista.localNascimento["Pais"] ?? "Unknown")"
        artistHistory.text = artista.descricao
        
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        self.selectionStyle = .none
        
    }
    
}
