import Foundation
import UIKit

class ListOfFilms: UIViewController {
    
    @IBOutlet weak var listFilmsTableView: FilmList!

    var genreFilms: [Film] = []
    var genreSeries: [Serie] = []
    var backWithColor: FilmDetailsBackColor!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        listFilmsTableView.filmsByArtist = genreFilms
        listFilmsTableView.seriesByArtist = genreSeries
        listFilmsTableView.tbvType = .movies
        listFilmsTableView.delegate = self
        
        navigationItem.title = " "
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if backWithColor == .blue {
            (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
            navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        } else {
            (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
            navigationController?.navigationBar.tintColor = .white
        }
        
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
