import Foundation
import UIKit

class AlbunsTableViewCell: UITableViewCell {
    @IBOutlet weak var names: UILabel!
    @IBOutlet weak var dateAndLocation: UILabel!
    @IBOutlet weak var albunsCollectionView: UICollectionView!
    
    func configure(_ album: PhotoAlbum)  {
        let month = Array(Utils.numberToMonth(album.data["Mes"]!))
        let initials = "\(month[0])\(month[1])\(month[2])"
        
        names.text = "\(album.fotografado) - Photoshoot for \(album.fotografo)"
        dateAndLocation.text = "\(initials) \(album.data["Dia"]!), \(album.data["Ano"]!) | \(album.local["Estado"]!), \(album.local["Pais"]!)"
        selectionStyle = .none
    }
    
}
