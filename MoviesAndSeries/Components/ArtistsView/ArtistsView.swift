import Foundation
import UIKit
import SDWebImage

protocol ArtistViewDelegate: class {
    func artistPressed(_ artista: Artist)
}

class ArtistsView: UIView {
    @IBOutlet weak var artist1: UIView!
    @IBOutlet weak var artist2: UIView!
    @IBOutlet weak var artist3: UIView!
    @IBOutlet weak var artist1Image: UIImageView!
    @IBOutlet weak var artist2Image: UIImageView!
    @IBOutlet weak var artist3Image: UIImageView!
    @IBOutlet weak var artist1Name: UILabel!
    @IBOutlet weak var artist2Name: UILabel!
    @IBOutlet weak var artist3Name: UILabel!
    @IBOutlet weak var artist2Button: UIButton!
    @IBOutlet weak var artist3Button: UIButton!
    
    weak var delegate: ArtistViewDelegate?
    var artistasSetados: [Artist] = []
    
    @IBAction func Artist1Clicked(_ sender: UIButton) {
        delegate?.artistPressed(artistasSetados[0])
    }
    
    @IBAction func Artist2Clicked(_ sender: UIButton) {
        delegate?.artistPressed(artistasSetados[1])
    }
    
    @IBAction func Artist3Clicked(_ sender: UIButton) {
        delegate?.artistPressed(artistasSetados[2])
    }
    
    func configure(_ artistas: [Artist]) {
        if artistas.count == 1 {
            artist2Button.isHidden = true
            artist2.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            artist2Name.text = ""
            
            artist3Button.isHidden = true
            artist3.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            artist3Name.text = ""
        } else if artistas.count == 2 {
            artist3Button.isHidden = true
            artist3.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            artist3Name.text = ""
        }
        
        for (index, artista) in artistas.enumerated() {
            setArtist(artista, inSpace: index)
        }
        
        artistasSetados = artistas
    }
    
    private func setArtist(_ artista: Artist, inSpace: Int) {
        switch inSpace {
        case 0:
            artist1Image.sd_setImage(with: artista.artistCollectionImage, completed: nil)
            artist1Name.text = artista.name
        case 1:
            artist2Image.sd_setImage(with: artista.artistCollectionImage, completed: nil)
            artist2Name.text = artista.name
        case 2:
            artist3Image.sd_setImage(with: artista.artistCollectionImage, completed: nil)
            artist3Name.text = artista.name
        default:
            break
        }
    }
    
}
