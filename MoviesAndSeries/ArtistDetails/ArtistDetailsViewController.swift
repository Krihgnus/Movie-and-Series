import Foundation
import UIKit
import SDWebImage



class ArtistDetailsViewController: UIViewController {
    var clickedartistId: Int!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainArtistPhoto: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistJobAndBornDate: UILabel!
    @IBOutlet weak var mainPhotoAlbum: UIView!
    @IBOutlet var mosaics: [UIView]!
    @IBOutlet var mosaicSixPhotos: [UIImageView]!
    @IBOutlet var mosaicFivePhotos: [UIImageView]!
    @IBOutlet var mosaicFourPhotos: [UIImageView]!
    @IBOutlet var mosaicThreePhotos: [UIImageView]!
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    @IBOutlet weak var buttonBar: UIView!
    @IBOutlet weak var artistDetailsTableView: FilmList!
    @IBOutlet var numberOfMorePhotos: [UILabel]!
    @IBOutlet weak var screenActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var spaceBetweenSegmentedBarAndMainImageConstraint: NSLayoutConstraint!
    var contentTableViewMoviesLoad = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedBar.clearSegmentedBar()
        segmentedBar.insertSegment(withTitle: "Summary", at: 0, animated: false)
        segmentedBar.insertSegment(withTitle: "Movies", at: 1, animated: false)
        segmentedBar.insertSegment(withTitle: "More", at: 2, animated: false)
        
        artistDetailsTableView.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        artistDetailsTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        
        segmentedBar.selectedSegmentIndex = 0
        indexChanged(segmentedBar)
        
        spaceBetweenSegmentedBarAndMainImageConstraint.constant = 110
        
        screenActivityIndicator.startAnimating()
        
        contentTableViewMoviesLoad = 0
        
        //Request
        ArtistsServer.takeArtist(byId: clickedartistId) { artistOptional in
            
            if let artista = artistOptional {
                
                self.mainArtistPhoto.sd_setImage(with: artista.imagemCapa, completed: nil)
                self.artistName.text = artista.nome
                self.artistJobAndBornDate.text = "\(artista.profissao) | \(Utils.numberToMonth(artista.dataNascimento["Mes"])) \(artista.dataNascimento["Dia"]!), \(artista.dataNascimento["Ano"]!)"
                let numberOfMorePhotos = Utils.photoCount(artista.outrosAlbuns)
                let textNumberOfMorePhotos = (numberOfMorePhotos < 10) ? "0\(numberOfMorePhotos)+" : "\(numberOfMorePhotos)+"
                
                //Mosaicos de fotos
                if artista.albumSecundario.fotos.count >= 6 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[0])
                    self.mosaics[0].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...5 {
                        
                        self.mosaicSixPhotos[indx].sd_setImage(with: artista.albumSecundario.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[3].text = textNumberOfMorePhotos
                    
                } else if artista.albumSecundario.fotos.count == 5 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[1])
                    self.mosaics[1].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...4 {
                        
                        self.mosaicFivePhotos[indx].sd_setImage(with: artista.albumSecundario.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[2].text = textNumberOfMorePhotos
                    
                } else if artista.albumSecundario.fotos.count == 4 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[2])
                    self.mosaics[2].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...3 {
                        
                        self.mosaicFourPhotos[indx].sd_setImage(with: artista.albumSecundario.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[1].text = textNumberOfMorePhotos
                    
                } else if artista.albumSecundario.fotos.count == 3 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[3])
                    self.mosaics[3].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...2 {
                        
                        self.mosaicThreePhotos[indx].sd_setImage(with: artista.albumSecundario.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[0].text = textNumberOfMorePhotos
                    
                } else {
                    
                    self.view.willRemoveSubview(self.mainPhotoAlbum)
                    self.spaceBetweenSegmentedBarAndMainImageConstraint.constant = 0
                    
                }
                
                self.navigationController?.navigationBar.tintColor = .white
                self.contentView.isHidden = false
                (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                
                self.artistDetailsTableView.artistToTableView = artista
                
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
            
            self.screenActivityIndicator.stopAnimating()
            
        }
        
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        overlay.setGradientBackground()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        
    }
    
    @IBAction func toPhotoAlbum(_ sender: UIButton) {
        
        //APEAS CHAMAR A VIEW DE PHOTO ALBUMS
        if let photoAlbunsViewController = storyboard?.instantiateViewController(withIdentifier: "photoAlbumsVC") as? PhotoAlbumViewController {
            
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
            artistDetailsTableView.tbvType = .summary
            artistDetailsTableView.reloadData()
            
        case 1:
            //Segunda aba selecionada
            tableViewActivityIndicator.startAnimating()
            artistDetailsTableView.rowHeight = 150
            artistDetailsTableView.tbvType = .movies
            starBarCurrentScreen = .noEvaluate
            artistDetailsTableView.isHidden = true
            artistDetailsTableView.reloadData()
            
            if artistDetailsTableView.filmsByArtist.count == artistDetailsTableView.artistToTableView.filmesId.count &&
                artistDetailsTableView.seriesByArtist.count == artistDetailsTableView.artistToTableView.seriesId.count {
                    
                artistDetailsTableView.isHidden = false
                tableViewActivityIndicator.stopAnimating()
        
            } else {
                
                requestFilmsAndSeries()
                
            }
            
        case 2:
            //Terceira aba selecionada
            artistDetailsTableView.tbvType = .more
            artistDetailsTableView.reloadData()
            
        default:
            return
            
        }
        
    }
    
    func requestFilmsAndSeries() {
        
        if artistDetailsTableView.artistToTableView.seriesId.count != artistDetailsTableView.seriesByArtist.count {
            
            //Request Series
            SeriesServer.takeSeries(by: artistDetailsTableView.artistToTableView.seriesId) { seriesOptional in
                
                if let series = seriesOptional {
                    
                    self.artistDetailsTableView.seriesByArtist = series
                    self.contentTableViewMoviesLoad += 1
                    
                    if self.contentTableViewMoviesLoad == 2 {
                        
                        self.artistDetailsTableView.reloadData()
                        self.artistDetailsTableView.isHidden = false
                        self.tableViewActivityIndicator.stopAnimating()
                        
                    }
                    
                } else {
                    
                    self.presentNetworkErrorAlert()
                    self.tableViewActivityIndicator.stopAnimating()
                    
                    print("Erro - Array de séries retornou nil do backend")
                    
                }
    
            }
            
        }
        
        if artistDetailsTableView.artistToTableView.filmesId.count != artistDetailsTableView.filmsByArtist.count {
            
            //Request Filmes
            FilmsSever.takeFilms(by: artistDetailsTableView.artistToTableView.filmesId) { filmsOptional in
                
                if let films = filmsOptional {
                    
                    self.artistDetailsTableView.filmsByArtist = films
                    self.contentTableViewMoviesLoad += 1
                    
                    if self.contentTableViewMoviesLoad == 2 {
                        
                        self.artistDetailsTableView.reloadData()
                        self.artistDetailsTableView.isHidden = false
                        self.tableViewActivityIndicator.stopAnimating()
                        
                    }
                    
                } else {
                    
                    self.presentNetworkErrorAlert()
                    self.tableViewActivityIndicator.stopAnimating()
                    
                    print("Erro - Array de filmes retornou nil do backend")
                    
                }
                
            }
            
        }

    }
    
}