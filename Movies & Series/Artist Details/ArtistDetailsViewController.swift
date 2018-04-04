import Foundation
import UIKit
import SDWebImage

class ArtistDetailsViewController: UIViewController {
    
    //ATUALIZAR COM BANCO DE DADOS
        //STATIC LET ARTISTA: ARTISTA!
    //ATUALIZAR COM BANCO DE DADOS
    
    //DELETAR COM BANCO DE DADOS
    var artista: [String] = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiFQXlU9X7A55ALM9zmantPWOvSLKaVHv9J44MKBUBtnP_DDH9", "NOME TESTE", "ACTRESS | August 25, 1987"]
    //DELETAR COM BANCO DE DADOS
    
    @IBOutlet weak var mainArtistPhoto: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistJobAndBornDate: UILabel!
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    @IBOutlet weak var buttonBar: UIView!
    @IBOutlet weak var artistDetailsTableView: FilmList!
    
    @IBOutlet weak var photoAlbumsHeight: NSLayoutConstraint!
    @IBOutlet weak var mainArtistPhotoHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedBar.clearSegmentedBar()
        segmentedBar.insertSegment(withTitle: "Summary", at: 0, animated: false)
        segmentedBar.insertSegment(withTitle: "Movies", at: 1, animated: false)
        segmentedBar.insertSegment(withTitle: "More", at: 2, animated: false)
        
        artistDetailsTableView.dataSource = FilmList.sharedTableView
        artistDetailsTableView.delegate = FilmList.sharedTableView
        
        photoAlbumsHeight.constant = artistDetailsTableView.frame.height / 2.6
        mainArtistPhotoHeight.constant = artistDetailsTableView.frame.height / 1.1
        artistDetailsTableView.rowHeight = photoAlbumsHeight.constant * 2.9
        
        artistDetailsTableView.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        
        mainArtistPhoto.sd_setImage(with: URL(string: artista[0]), completed: nil) //mainArtistPhoto.sd_setImage(with: artista.mainImageLink(OU SEMELHANTE)(: URL), completed: nil)
        artistName.text = artista[1] //artistName.text = artista.name (OU SEMELHANTE)
        artistJobAndBornDate.text = artista[2] //artistJobAndBornDate.text = "\(artista.job (OU SEMELHANTE) | artista.bornDate (OU SEMELHANTE))"
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedBar.frame.width / 3) * CGFloat(self.segmentedBar.selectedSegmentIndex)
        }
        
        switch segmentedBar.selectedSegmentIndex {
        case 0:
            //PRIMEIRA ABA SELECIONADA
            artistDetailsTableView.rowHeight = artistDetailsTableView.frame.height
            typeTableView = .summary
            artistDetailsTableView.reloadData()
        case 1:
            //SEGUNDA ABA SELECIONADA
            artistDetailsTableView.rowHeight = 150
            typeTableView = .movies
            starBarCurrentScreen = .noEvaluate
            artistDetailsTableView.reloadData()
        case 2:
            //TERCEIRA ABA SELECIONADA
            typeTableView = .more
            artistDetailsTableView.reloadData()
        default:
            return
        }
    }

}
