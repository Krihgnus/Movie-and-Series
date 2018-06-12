import Foundation
import UIKit
import SDWebImage

protocol MovieClicked: class {
    func cellClicked(film: Film?, serie: Serie?)
}

class RecommendedMovieView: UIView {
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmCategories: UILabel!
    @IBOutlet weak var stars: UIView!
    
    weak var delegate: MovieClicked?
    var filmInThisCell: Film!
    var serieInThisCell: Serie!
    
    @IBAction func movieSelected(_ sender: UIButton) {
        if let _ = filmInThisCell {
            delegate?.cellClicked(film: filmInThisCell, serie: nil)
        } else {
            delegate?.cellClicked(film: nil, serie: serieInThisCell)
        }
    }
    
    func configure(_ film: Film?, _ serie: Serie?) {
        if let _ = film {
            filmImage.sd_setImage(with: film?.capa, completed: nil)
            filmName.text = film?.nome
            filmCategories.text = Utils.arrCategoriesToString(film?.categorias ?? [])
            
            filmInThisCell = film
        } else {
            filmImage.sd_setImage(with: serie?.capa, completed: nil)
            filmName.text = serie?.nome
            filmCategories.text = Utils.arrCategoriesToString(serie?.categorias ?? [])
            
            serieInThisCell = serie
        }
        
        guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        
        stars.addSubview(starBarReference)
        
        starBarReference.translatesAutoresizingMaskIntoConstraints = false
        starBarReference.topAnchor.constraint(equalTo: stars.topAnchor, constant: 0).isActive = true
        starBarReference.bottomAnchor.constraint(equalTo: stars.bottomAnchor, constant: 0).isActive = true
        starBarReference.leadingAnchor.constraint(equalTo: stars.leadingAnchor, constant: 0).isActive = true
        starBarReference.trailingAnchor.constraint(equalTo: stars.trailingAnchor, constant: 0).isActive = true
        
        if let _ = film {
            starBarReference.fillStars(Utils.reviewsToAverageStar(film?.avaliacoes ?? []))
        } else {
            starBarReference.fillStars(Utils.reviewsToAverageStar(serie?.avaliacoes ?? []))
        }
        
    }
}
