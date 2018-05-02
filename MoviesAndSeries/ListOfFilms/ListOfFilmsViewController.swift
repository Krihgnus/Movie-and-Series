import Foundation
import UIKit

class ListOfFilms: UIViewController {
    
    @IBOutlet weak var listFilmsTableView: FilmList!

    var genreFilms: [Film] = []
    var genreSeries: [Serie] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        listFilmsTableView.filmsByArtist = genreFilms
        listFilmsTableView.seriesByArtist = genreSeries
        listFilmsTableView.tbvType = .movies
        listFilmsTableView.delegate = self
        
        navigationItem.title = " "
        
    }
    
}

extension ListOfFilms: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        if let movieDetailsReference = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController {
                
            if indexPath.row < genreFilms.count {
                    
                movieDetailsReference.idToRequest = genreFilms[indexPath.row].identifier
                movieDetailsReference.requestType = .filme
                    
            } else {
                    
                movieDetailsReference.idToRequest = genreSeries[indexPath.row - genreFilms.count].identifier
                movieDetailsReference.requestType = .serie
                    
            }
                
            movieDetailsReference.backWithColor = .blue
            navigationController?.pushViewController(movieDetailsReference, animated: true)
                
        }
        
    }
    
}