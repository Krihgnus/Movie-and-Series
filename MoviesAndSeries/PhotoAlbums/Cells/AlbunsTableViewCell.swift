import Foundation
import UIKit

class AlbunsTableViewCell: UITableViewCell {
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var dateAndLocation: UILabel!
    @IBOutlet weak var albunsCollectionView: UICollectionView!
    
    func configure(_ album: PhotoAlbum)  {
        let month = Array(Utils.numberToMonth(album.date["Mes"]!))
        let initials = "\(month[0])\(month[1])\(month[2])"
        
        albumTitle.text = "\(album.artistName) - Photoshoot for \(album.photographer)"
        dateAndLocation.text = "\(initials) \(album.date["Dia"]!), \(album.date["Ano"]!) | \(album.local["Estado"]!), \(album.local["Pais"]!)"
        selectionStyle = .none
    }
    
}
