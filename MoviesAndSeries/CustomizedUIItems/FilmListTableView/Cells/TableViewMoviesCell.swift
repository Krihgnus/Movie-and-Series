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
    
    func configureFilm(_ film: Film) { //FUNC CONFIGURE(_ FILM: FILME) - ATUALIZADO
        movieImage.sd_setImage(with: film.capa, completed: nil) //MOVIEIMAGE.IMAGE.SD_SETIMAGE(WITH: FILME.URLIMAGE (OU SEMELHANTE), COMPLETED: NIL) - ATUALIZADO
        movieName.text = film.nome //MOVIENAME.TEXT = FILME.NAME (OU SEMELHANTE) - ATUALIZADO
        movieCategories.text = Utils.listCategories(film.categorias) //MOVIECATEGORIES.TEXT = FILME.CATEGORIES = [STRING] - ATUALIZADO
        guard let starBarViewReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        stars.addSubview(starBarViewReference)
        starBarViewReference.fillStars(film.mediaEstrelas) //STARBARVIEWREFERENCE.FILLSTARS(FILME.AVERAGESTARS: INT (OU SEMELHANTE)) - ATUALIZADO
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        self.selectionStyle = .none
    }
    
    func configureSerie(_ serie: Serie) {
        movieImage.sd_setImage(with: serie.capa, completed: nil)
        movieName.text = serie.nome
        movieCategories.text = Utils.listCategories(serie.categorias)
        guard let starBarViewReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        stars.addSubview(starBarViewReference)
        starBarViewReference.fillStars(serie.mediaEstrelas)
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        self.selectionStyle = .none
    }
}
