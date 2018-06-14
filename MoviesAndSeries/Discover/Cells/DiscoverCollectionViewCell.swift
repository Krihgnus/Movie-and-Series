import Foundation
import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var filmSerieCover: UIImageView!
    @IBOutlet weak var filmSerieName: UILabel!
    @IBOutlet weak var filmSerieDuration: UILabel!
    
    weak var delegate: MovieClicked?
    
    @IBAction func itemClicked(_ sender: UIButton) {
        if let _ = itemMovie {
            delegate?.cellClicked(film: itemMovie, serie: nil)
        } else if let _ = itemSerie {
            delegate?.cellClicked(film: nil, serie: itemSerie)
        }
    }
    
    var itemMovie: Film?
    var itemSerie: Serie?
    
    func configure(film: Film?, serie: Serie?) {
        if let _ = film {
            filmSerieCover.sd_setImage(with: film?.capa, completed: nil)
            filmSerieName.text = film?.nome
            filmSerieDuration.text = film?.duracao
            itemMovie = film
        } else if let _ = serie {
            filmSerieCover.sd_setImage(with: serie?.capa, completed: nil)
            filmSerieName.text = serie?.nome
            filmSerieDuration.text = "\(serie?.duracaoEpisodio ?? 00) min"
            itemSerie = serie
        }
    }
}
