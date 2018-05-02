import Foundation
import UIKit
import SDWebImage

class CellMoviesType: UITableViewCell {
    
    static let identifier = "movieCell"
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieCategories: UILabel!
    @IBOutlet weak var stars: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImage.image = nil
        movieName.text = nil
        movieCategories.text = nil
        
    }
    
    //Cofigurando um filme
    func configureFilm(_ film: Film) {
        
        movieImage.sd_setImage(with: film.capa, completed: nil)
        movieName.text = film.nome
        movieCategories.text = Utils.arrCategoriesToString(film.categorias)
        
        guard let starBarViewReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        stars.addSubview(starBarViewReference)
        starBarViewReference.fillStars(film.mediaEstrelas)
        
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        self.selectionStyle = .none
    }

    //Configurando uma série
    func configureSerie(_ serie: Serie) {
        
        movieImage.sd_setImage(with: serie.capa, completed: nil)
        movieName.text = serie.nome
        
        for (indx, texto) in serie.categorias.enumerated() {
            
            if indx == 0 {
                
                movieCategories.text = "\(texto)"
                
            } else {
                
                movieCategories.text! += " | \(texto)"
                
            }
            
        }
        
        guard let starBarViewReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        stars.addSubview(starBarViewReference)
        starBarViewReference.fillStars(serie.mediaEstrelas)
        
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        self.selectionStyle = .none
    }
    
}
