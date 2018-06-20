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

    var backWithColor: FilmDetailsBackColor!
    var sumaryCellHeight: CGFloat = 0
    var contentTableViewMoviesLoad = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedBar.clearSegmentedBar()
        segmentedBar.insertSegment(withTitle: "Summary", at: 0, animated: false)
        segmentedBar.insertSegment(withTitle: "Movies", at: 1, animated: false)
        segmentedBar.insertSegment(withTitle: "More", at: 2, animated: false)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        
        spaceBetweenSegmentedBarAndMainImageConstraint.constant = 110
        
        screenActivityIndicator.startAnimating()
        
        contentTableViewMoviesLoad = 0
        
        artistDetailsTableView.delegate = self
        
        navigationItem.title = " "
        
        //Request
        ArtistsServer.takeArtist(byId: clickedartistId) { artistOptional in
            
            if let artist = artistOptional {
                
                self.mainArtistPhoto.sd_setImage(with: artist.coverImage, completed: nil)
                self.artistName.text = artist.name
                self.artistJobAndBornDate.text = "\(artist.work) | \(Utils.numberToMonth(artist.birthDate["Mes"])) \(artist.birthDate["Dia"]!), \(artist.birthDate["Ano"]!)"
                let numberOfMorePhotos = Utils.photoCount(artist.otherAlbums)
                let textNumberOfMorePhotos = (numberOfMorePhotos < 10) ? "0\(numberOfMorePhotos)+" : "\(numberOfMorePhotos)+"
                
                //Mosaicos de fotos
                if artist.secondaryAlbum.fotos.count >= 6 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[0])
                    self.mosaics[0].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...5 {
                        
                        self.mosaicSixPhotos[indx].sd_setImage(with: artist.secondaryAlbum.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[3].text = textNumberOfMorePhotos
                    
                } else if artist.secondaryAlbum.fotos.count == 5 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[1])
                    self.mosaics[1].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...4 {
                        
                        self.mosaicFivePhotos[indx].sd_setImage(with: artist.secondaryAlbum.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[2].text = textNumberOfMorePhotos
                    
                } else if artist.secondaryAlbum.fotos.count == 4 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[2])
                    self.mosaics[2].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...3 {
                        
                        self.mosaicFourPhotos[indx].sd_setImage(with: artist.secondaryAlbum.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[1].text = textNumberOfMorePhotos
                    
                } else if artist.secondaryAlbum.fotos.count == 3 {
                    
                    self.mainPhotoAlbum.addSubview(self.mosaics[3])
                    self.mosaics[3].frame = self.mainPhotoAlbum.bounds
                    
                    for indx in 0...2 {
                        
                        self.mosaicThreePhotos[indx].sd_setImage(with: artist.secondaryAlbum.fotos[indx], completed: nil)
                        
                    }
                    
                    self.numberOfMorePhotos[0].text = textNumberOfMorePhotos
                    
                } else {
                    
                    self.view.willRemoveSubview(self.mainPhotoAlbum)
                    self.spaceBetweenSegmentedBarAndMainImageConstraint.constant = 0
                    
                }
                
                self.navigationController?.navigationBar.tintColor = .white
                self.contentView.isHidden = false
                (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                
                self.artistDetailsTableView.artistToTableView = artist
                
                self.sumaryCellHeight = self.artistDetailsTableView.frame.height
                self.segmentedBar.selectedSegmentIndex = 0
                self.indexChanged(self.segmentedBar)
                
            } else {
                
                self.presentNetworkErrorAlert()
                print("Erro - Nil como resposta do backend")
                
            }
            
            self.screenActivityIndicator.stopAnimating()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        segmentedBar.selectedSegmentIndex = 0
        indexChanged(segmentedBar)
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        overlay.setGradientBackground(.gray)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if backWithColor == .blue {
            (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        } else {
            (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
        }
        
    }
    
    @IBAction func toPhotoAlbum(_ sender: UIButton) {
        guard let photoAlbunsReference = storyboard?.instantiateViewController(withIdentifier: "photoAlbumsVC") as? PhotoAlbumViewController else { return }
        photoAlbunsReference.albuns = artistDetailsTableView.artistToTableView.otherAlbums
        navigationController?.pushViewController(photoAlbunsReference, animated: true)
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedBar.frame.width / 3) * CGFloat(self.segmentedBar.selectedSegmentIndex)
        }
        
        switch segmentedBar.selectedSegmentIndex {
        case 0:
            //Primeira aba selecionada
            artistDetailsTableView.rowHeight = sumaryCellHeight
            artistDetailsTableView.tbvType = .summary
            artistDetailsTableView.reloadData()
            artistDetailsTableView.isHidden = false
            tableViewActivityIndicator.stopAnimating()
            
        case 1:
            //Segunda aba selecionada
            tableViewActivityIndicator.startAnimating()
            artistDetailsTableView.rowHeight = 150
            artistDetailsTableView.tbvType = .movies
            artistDetailsTableView.isHidden = true
            requestFilmsAndSeries()
            
        case 2:
            //Terceira aba selecionada
            artistDetailsTableView.tbvType = .more
            artistDetailsTableView.reloadData()
            artistDetailsTableView.isHidden = false
            tableViewActivityIndicator.stopAnimating()
            
        default:
            return
        }
    }
    
    func requestFilmsAndSeries() {
        contentTableViewMoviesLoad = 0
        
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
                if self.artistDetailsTableView.tbvType == .movies {
                    self.presentNetworkErrorAlert()
                    self.tableViewActivityIndicator.stopAnimating()
                    print("Erro - Array de séries retornou nil do backend")
                }
            }
        }
        
        //Request Filmes
        FilmsSever.takeFilms(by: artistDetailsTableView.artistToTableView.moviesId) { filmsOptional in
            if let films = filmsOptional {
                self.artistDetailsTableView.filmsByArtist = films
                self.contentTableViewMoviesLoad += 1
                if self.contentTableViewMoviesLoad == 2 {
                    self.artistDetailsTableView.reloadData()
                    self.artistDetailsTableView.isHidden = false
                    self.tableViewActivityIndicator.stopAnimating()
                }
            } else {
                if self.artistDetailsTableView.tbvType == .movies {
                    self.presentNetworkErrorAlert()
                    self.tableViewActivityIndicator.stopAnimating()
                    print("Erro - Array de filmes retornou nil do backend")
                }
            }
        }
    }
}

extension ArtistDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if artistDetailsTableView.tbvType == .movies {
            if let movieDetailsReference = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController {
                if indexPath.row < artistDetailsTableView.filmsByArtist.count {
                    movieDetailsReference.idToRequest = artistDetailsTableView.filmsByArtist[indexPath.row].identifier
                    movieDetailsReference.requestType = .filme
                } else {
                    movieDetailsReference.idToRequest = artistDetailsTableView.seriesByArtist[indexPath.row - artistDetailsTableView.filmsByArtist.count].identifier
                    movieDetailsReference.requestType = .serie
                }
                movieDetailsReference.backWithColor = .white
                navigationController?.pushViewController(movieDetailsReference, animated: true)
            }
        }
    }
}
