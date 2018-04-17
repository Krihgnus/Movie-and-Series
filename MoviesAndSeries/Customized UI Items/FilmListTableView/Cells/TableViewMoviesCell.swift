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
    
    func configure(_ film: [String: String]) { //FUNC CONFIGURE(_ FILM: FILME)
        movieImage.image = UIImage(imageLiteralResourceName: "star-off") //MOVIEIMAGE.IMAGE.SD_SETIMAGE(WITH: FILME.URLIMAGE (OU SEMELHANTE), COMPLETED: NIL)
        movieName.text = film["name"] //MOVIENAME.TEXT = FILME.NAME (OU SEMELHANTE)
        movieCategories.text = film["categories"] //MOVIECATEGORIES.TEXT = FILME.CATEGORIES = [STRING] -> FUNC Q PASSA ESTE ARRAY PARA UMA FRASE COM SEPARACAO DE MODULOS
        guard let starBarViewReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        stars.addSubview(starBarViewReference)
        starBarViewReference.fillStars(3) //STARBARVIEWREFERENCE.FILLSTARS(FILME.AVERAGESTARS: INT (OU SEMELHANTE))
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        self.selectionStyle = .none
    }
}
