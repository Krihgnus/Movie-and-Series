import Foundation
import UIKit

class ListOfFilms: UIViewController {
    
    @IBOutlet weak var listFilmsTableView: FilmList!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var genreFilms: [Film] = []
    var genreSeries: [Serie] = []
    var backWithColor: FilmDetailsBackColor!
    var ids: [Int] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var contentLoad: Int = 0
        
        activityIndicator.startAnimating()
        listFilmsTableView.isHidden = true
        
        ids = []
        for actFilm in genreFilms {
            ids.append(actFilm.identifier)
        }
        
        //Request filmes especificos
        FilmsSever.takeFilms(by: ids) { films in
            if let filmes = films {
                self.genreFilms = filmes
                
                contentLoad += 1
                if contentLoad == 2 {
                    self.listFilmsTableView.filmsByArtist = self.genreFilms
                    self.listFilmsTableView.seriesByArtist = self.genreSeries
                    self.listFilmsTableView.reloadData()
                    self.listFilmsTableView.isHidden = false
                    self.activityIndicator.stopAnimating()
                }
            } else {
                //REQUEST RETORNOU NIL
            }
        }
        
        ids = []
        for actSerie in genreSeries {
            ids.append(actSerie.identifier)
        }
        
        //Rwquest series especificas
        SeriesServer.takeSeries(by: ids) { series in
            if let seriesC = series {
                self.genreSeries = seriesC
                
                contentLoad += 1
                if contentLoad == 2 {
                    self.listFilmsTableView.filmsByArtist = self.genreFilms
                    self.listFilmsTableView.seriesByArtist = self.genreSeries
                    self.listFilmsTableView.reloadData()
                    self.listFilmsTableView.isHidden = false
                    self.activityIndicator.stopAnimating()
                }
            } else {
                //REQUEST RETORNOU NIL
            }
        }
        
        navigationItem.title = " "
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        listFilmsTableView.tbvType = .unlimitedMovies
        listFilmsTableView.delegate = self
        
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
