import Foundation
import UIKit
import SDWebImage

var clickedartistId = -1

var filmsByArtist: [Film] = []
var seriesByArtist: [Serie] = []

class ArtistDetailsViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainArtistPhoto: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistJobAndBornDate: UILabel!
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    @IBOutlet weak var buttonBar: UIView!
    @IBOutlet weak var artistDetailsTableView: FilmList!
    @IBOutlet weak var photoAlbumsHeight: NSLayoutConstraint!
    @IBOutlet weak var mainArtistPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var photosInOtherAlbums: UILabel!
    @IBOutlet var secondaryPhotoAlbum: [UIImageView]!
    @IBOutlet weak var viewControllerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieTabActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func toPhotoAlbum(_ sender: UIButton) {
        
        if let photoAlbunsViewController = self.storyboard?.instantiateViewController(withIdentifier: "photoAlbumsVC") as? PhotoAlbumViewController {
            
            navigationController?.pushViewController(photoAlbunsViewController, animated: true)
            
        }
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.buttonBar.frame.origin.x = (self.segmentedBar.frame.width / 3) * CGFloat(self.segmentedBar.selectedSegmentIndex)
            
        }
        
        switch segmentedBar.selectedSegmentIndex {
            
        case 0:
            //Primeira aba selecionada
            artistDetailsTableView.rowHeight = artistDetailsTableView.frame.height
            typeTableView = .summary
            movieTabActivityIndicator.stopAnimating()
            artistDetailsTableView.reloadData()
            
        case 1:
            //Segunda aba selecionada
            artistDetailsTableView.rowHeight = 150
            typeTableView = .movies
            starBarCurrentScreen = .noEvaluate
            movieTabActivityIndicator.startAnimating()
            artistDetailsTableView.isHidden = true
            
            if atrtistToFilmListTableView.seriesId.count != seriesByArtist.count {
                    
                //Request Series
                SeriesServer.takeSeries(by: atrtistToFilmListTableView.seriesId) { seriesOptional in
                        
                    if let series = seriesOptional {
                            
                        seriesByArtist = series
                            
                        if filmsByArtist.count == atrtistToFilmListTableView.filmesId.count {
                                
                            self.artistDetailsTableView.reloadData()
                            self.movieTabActivityIndicator.stopAnimating()
                            self.artistDetailsTableView.isHidden = false
                                
                        }
                            
                    } else {
                            
                        self.movieTabActivityIndicator.stopAnimating()
                        self.presentNetworkErrorAlert()
                        print("Erro - Array de séries retornou nil")
                            
                    }
                        
                }
                    
            }
            
            if atrtistToFilmListTableView.filmesId.count != filmsByArtist.count {
                    
                //Request Filmes
                FilmsSever.takeFilms(by: atrtistToFilmListTableView.filmesId) { filmsOptional in
                        
                    if let films = filmsOptional {
                            
                        filmsByArtist = films
                            
                        if seriesByArtist.count == atrtistToFilmListTableView.seriesId.count {
                                
                            self.artistDetailsTableView.reloadData()
                            self.movieTabActivityIndicator.stopAnimating()
                            self.artistDetailsTableView.isHidden = false
                                
                        }
                            
                    } else {
                            
                        self.movieTabActivityIndicator.stopAnimating()
                        self.presentNetworkErrorAlert()
                        print("Erro - Array de filmes retornou nil")
                            
                    }
                    
                }
                    
            }
            
            if filmsByArtist.count == atrtistToFilmListTableView.filmesId.count && seriesByArtist.count == atrtistToFilmListTableView.seriesId.count {
                
                artistDetailsTableView.reloadData()
                movieTabActivityIndicator.stopAnimating()
                artistDetailsTableView.isHidden = false
                
            }
            
        case 2:
            //Terceira aba selecionada
            typeTableView = .more
            movieTabActivityIndicator.stopAnimating()
            artistDetailsTableView.reloadData()
            
        default:
            return
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        seriesByArtist = []
        filmsByArtist = []
        
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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        
        segmentedBar.selectedSegmentIndex = 0
        indexChanged(segmentedBar)
        
        viewControllerActivityIndicator.startAnimating()
        //Request
        ArtistsServer.takeArtist(byId: clickedartistId) { artistOptional in
            
            if let artista = artistOptional {
                
                self.mainArtistPhoto.sd_setImage(with: artista.imagemCapa, completed: nil)
                self.artistName.text = artista.nome
                self.artistJobAndBornDate.text = "\(artista.profissao) | \(Utils.numberToMonth(artista.dataNascimento["Mes"])) \(artista.dataNascimento["Dia"]!), \(artista.dataNascimento["Ano"]!)"
                self.photosInOtherAlbums.text = "\(Utils.photoCount(artista.outrosAlbuns)) +"
                
                if Utils.photoCount(artista.outrosAlbuns) < 10 {
                    
                    self.photosInOtherAlbums.text = "0\(Utils.photoCount(artista.outrosAlbuns)) +"
                    
                }
                
                for indx in 0...5 {
                    self.secondaryPhotoAlbum[indx].sd_setImage(with: artista.albumSecundario.fotos[indx], completed: nil)
                    
                }
                
                self.navigationController?.navigationBar.tintColor = .white
                self.contentView.isHidden = false
                (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                atrtistToFilmListTableView = artista
                //DELETAR QUANDO A VIEW PHOTOALBUMS FOR CRIADA
                    artistNamePhotoAlbums = artista.nome
                //DELETAR QUANDO A VIEW PHOTOALBUMS FOR CRIADA
                //ADICIONAR QUANDO A VIEW PHOTOALBUMS FOR CRIADA
                    //VAR GLOBAL OTHERALBUMSARTIST = ARTISTA.OUTROSALBUNS
                //ADICIONAR QUANDO A VIEW PHOTOALBUMS FOR CRIADA
                
            } else {
                
                self.presentNetworkErrorAlert()
                print("Erro - Nil como resposta do backend")
                
            }
            
            self.viewControllerActivityIndicator.stopAnimating()
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        
    }
    
}
