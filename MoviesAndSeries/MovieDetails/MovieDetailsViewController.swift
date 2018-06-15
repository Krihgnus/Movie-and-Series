import Foundation
import UIKit
import SDWebImage
import AVKit
import ExpandableLabel

enum FilmDetailsBackColor {
    case white
    case blue
}

enum SeeAllContent {
    case reviews
    case actors
}

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var capaView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var starsView: UIView!
    @IBOutlet weak var mediaAndTotalReviewsLabel: UILabel!
    @IBOutlet weak var lenguageLabel: UILabel!
    @IBOutlet weak var launchLabel: UILabel!
    @IBOutlet weak var descriptionLabel: ExpandableLabel!
    @IBOutlet weak var segmentedBarBottomView: UIView!
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var screenActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentStackView: UIStackView!
    
    var backWithColor: FilmDetailsBackColor!
    var idToRequest: Int!
    var requestType: FilmeSerie!
    var trailer: URL!
    var runningVideo: Bool = false
    var film: Film!
    var serie: Serie!
    var contentMoreLoaded: Int = 0
    var artistas: [Artist] = []
    var writeReviewViewControllerReference: WriteReviewViewController!
    var artistsToDelegate: [Artist] = []
    var numberOfCells = 0
    var seeAllContent: SeeAllContent = .reviews
    var starBarReference: StarBarView?
    
    @IBAction func playVideoButton(_ sender: Any) {
        
        playVideo()
        
    }
    
    @objc func threePointsButtonClicked(sender:UIButton!) {
        
        let actionSheet = UIAlertController(title: nil, message: "Choose your action", preferredStyle: .actionSheet)
        
        let writeAction = UIAlertAction(title: "Write a Review", style: .default, handler: {
            
            (alert: UIAlertAction!) -> Void  in
            
            if let _ = self.film {
                
                self.writeReviewViewControllerReference.filmeSerieId = self.film.identifier
                self.writeReviewViewControllerReference.filmSerieType = .filme
                
            } else {
                
                self.writeReviewViewControllerReference.filmeSerieId = self.serie.identifier
                self.writeReviewViewControllerReference.filmSerieType = .serie
                
            }
            
            self.navigationController?.pushViewController(self.writeReviewViewControllerReference, animated: true)
            
        })
        
        actionSheet.addAction(writeAction)
        actionSheet.addAction(UIAlertAction(title: "Share", style: .default))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(actionSheet , animated: true , completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        navigationItem.title = " "
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        
        let threePointsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        threePointsButton.setImage(UIImage(imageLiteralResourceName: "threePointsIcon"), for: .normal)
        threePointsButton.setImage(UIImage(imageLiteralResourceName: "threePointsIcon"), for: .highlighted)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: threePointsButton)
        threePointsButton.addTarget(self, action: #selector(threePointsButtonClicked), for: .touchUpInside)
        
        segmentedBar.clearSegmentedBar()
        segmentedBar.insertSegment(withTitle: "Cast", at: 0, animated: false)
        segmentedBar.insertSegment(withTitle: "Reviews", at: 1, animated: false)
        segmentedBar.insertSegment(withTitle: "More", at: 2, animated: false)
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        contentStackView.isHidden = true
        screenActivityIndicator.startAnimating()
    
        if let writeReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "writeReviewVC") as? WriteReviewViewController {
            self.writeReviewViewControllerReference = writeReviewViewController
        }
        
        switch requestType {
            
        case .filme:
            //Request Filme
            FilmsSever.takeFilm(by: idToRequest) { filmRequest in
                
                if let film = filmRequest {
                    
                    self.thumbnailView.sd_setImage(with: film.capa, completed: nil)
                    self.capaView.sd_setImage(with: film.capa, completed: nil)
                    self.nameLabel.text = film.nome
                    self.genresLabel.text = Utils.arrCategoriesToString(film.categorias)
                    self.lenguageLabel.text = "Lenguage: \(film.linguagemOriginal)"
                    self.mediaAndTotalReviewsLabel.text = "\(Utils.reviewsToAverageStar(film.avaliacoes)).0  /  \(film.avaliacoes.count)"
                    self.launchLabel.text = "\(Utils.numberToMonth(film.dataLancamento["Mes"])) \(String(film.dataLancamento["Dia"]!)), \(String(film.dataLancamento["Ano"]!) ) (\(film.siglaPaisLancamento)) \(film.duracao)"
                    self.trailer = film.trailer
                    
                    //Implementando pod ExpandableLabel
                    let attributedStringColor = [NSAttributedStringKey.foregroundColor : UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)];
                    self.descriptionLabel.collapsedAttributedLink =  NSAttributedString(string: "show all", attributes: attributedStringColor)
                    self.descriptionLabel.setLessLinkWith(lessLink: "hide", attributes: [.foregroundColor: UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)], position: .right)
                    self.descriptionLabel.textReplacementType = .word
                    self.descriptionLabel.numberOfLines = 3
                    self.descriptionLabel.text = film.descricao
                    self.descriptionLabel.shouldCollapse = true
                    
                    guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
                    self.starsView.addSubview(starBarReference)
                    
                    starBarReference.translatesAutoresizingMaskIntoConstraints = false
                    starBarReference.topAnchor.constraint(equalTo: self.starsView.topAnchor, constant: 0).isActive = true
                    starBarReference.bottomAnchor.constraint(equalTo: self.starsView.bottomAnchor, constant: 0).isActive = true
                    starBarReference.leadingAnchor.constraint(equalTo: self.starsView.leadingAnchor, constant: 0).isActive = true
                    starBarReference.trailingAnchor.constraint(equalTo: self.starsView.trailingAnchor, constant: 0).isActive = true
                    starBarReference.fillStars(Utils.reviewsToAverageStar(film.avaliacoes))
                    self.starBarReference = starBarReference
                    
                    self.contentStackView.isHidden = false
                    self.navigationController?.navigationBar.tintColor = .white
                    (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                    self.screenActivityIndicator.stopAnimating()
                    
                    self.artistas = film.atores
                    
                    self.writeReviewViewControllerReference.sendReview = film.avaliacoes[0]
                    self.film = film
                    
                    self.segmentedBar.selectedSegmentIndex = 0
                    self.indexChanged(self.segmentedBar)
                    
                } else {
                    
                    self.presentNetworkErrorAlert()
                    print("Erro - Request de filme pelo ID retornou nil")
                    self.screenActivityIndicator.stopAnimating()
                    
                }
                
            }
            
        case .serie:
            //Request Serie
            SeriesServer.takeSerie(by: idToRequest, onCompletion: { serieRequest in
                
                if let serie = serieRequest {
                    
                    self.thumbnailView.sd_setImage(with: serie.capa, completed: nil)
                    self.capaView.sd_setImage(with: serie.capa, completed: nil)
                    self.nameLabel.text = serie.nome
                    self.genresLabel.text = Utils.arrCategoriesToString(serie.categorias)
                    self.lenguageLabel.text = "Lenguage: \(serie.linguagemOriginal)"
                    self.mediaAndTotalReviewsLabel.text = "\(Utils.reviewsToAverageStar(serie.avaliacoes)).0  /  \(serie.avaliacoes.count)"
                    self.launchLabel.text = "\(Utils.numberToMonth(serie.dataLancamento["Mes"])) \(String(serie.dataLancamento["Dia"]!)), \(String(serie.dataLancamento["Ano"]!) ) (\(serie.siglaPaisLancamento)) \(serie.nEpisodios) ep / \(serie.duracaoEpisodio) min"
                    self.trailer = serie.trailer
                    
                    //Implementando pod ExpandableLabel
                    let attributedStringColor = [NSAttributedStringKey.foregroundColor : UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)];
                    self.descriptionLabel.collapsedAttributedLink =  NSAttributedString(string: "show all", attributes: attributedStringColor)
                    self.descriptionLabel.setLessLinkWith(lessLink: "hide", attributes: [.foregroundColor: UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)], position: .right)
                    self.descriptionLabel.shouldCollapse = true
                    self.descriptionLabel.textReplacementType = .word
                    self.descriptionLabel.numberOfLines = 3
                    self.descriptionLabel.text = serie.descricao
                    
                    guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
                    self.starsView.addSubview(starBarReference)
                    
                    starBarReference.translatesAutoresizingMaskIntoConstraints = false
                    starBarReference.topAnchor.constraint(equalTo: self.starsView.topAnchor, constant: 0).isActive = true
                    starBarReference.bottomAnchor.constraint(equalTo: self.starsView.bottomAnchor, constant: 0).isActive = true
                    starBarReference.leadingAnchor.constraint(equalTo: self.starsView.leadingAnchor, constant: 0).isActive = true
                    starBarReference.trailingAnchor.constraint(equalTo: self.starsView.trailingAnchor, constant: 0).isActive = true
                    starBarReference.fillStars(Utils.reviewsToAverageStar(serie.avaliacoes))
                    self.starBarReference = starBarReference
                    
                    self.contentStackView.isHidden = false
                    self.navigationController?.navigationBar.tintColor = .white
                    (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                    self.screenActivityIndicator.stopAnimating()
                    
                    self.artistas = serie.atores
                    
                    self.writeReviewViewControllerReference.sendReview = serie.avaliacoes[0]
                    self.serie = serie

                    self.segmentedBar.selectedSegmentIndex = 0
                    self.indexChanged(self.segmentedBar)
                    
                } else {
                    
                    self.presentNetworkErrorAlert()
                    print("Erro - Request de filme pelo ID retornou nil")
                    self.screenActivityIndicator.stopAnimating()
                    
                }
                
            })
            
        default:
            break
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.gradientView.setGradientBackground(.white)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if runningVideo == true {
            runningVideo = false
        }
        
        if let writtenReview = writeReviewViewControllerReference.sendReview {
            
            if let _ = film {
                film.avaliacoes.append(writtenReview)
                mediaAndTotalReviewsLabel.text = "\(Utils.reviewsToAverageStar(film.avaliacoes)).0  /  \(film.avaliacoes.count)"
                starBarReference?.fillStars(Utils.reviewsToAverageStar(film.avaliacoes))
            } else {
                serie.avaliacoes.append(writtenReview)
                mediaAndTotalReviewsLabel.text = "\(Utils.reviewsToAverageStar(serie.avaliacoes)).0  /  \(serie.avaliacoes.count)"
                starBarReference?.fillStars(Utils.reviewsToAverageStar(serie.avaliacoes))
            }
            
        }
        
        if numberOfCells > 0 {
            segmentedBar.selectedSegmentIndex = 0
            indexChanged(segmentedBar)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if backWithColor == .white || runningVideo == true {
            navigationController?.navigationBar.tintColor = .white
            (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
        } else {
            navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
            (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        }
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        UIView.animate(withDuration: 0.3) {
            self.segmentedBarBottomView.frame.origin.x = (self.segmentedBar.frame.width / 3) * CGFloat(self.segmentedBar.selectedSegmentIndex)
        }
        
        switch segmentedBar.selectedSegmentIndex {
            
        case 0:
            //ABA CAST SELECIONADA
            for (index, subview) in contentStackView.arrangedSubviews.enumerated() {
                if index >= 2 {
                    subview.removeFromSuperview()
                }
            }
            
            numberOfCells = 0
            artistsToDelegate = []
            if let _ = self.film {
                for artista in film.atores {
                    if self.numberOfCells < 2 {
                        if self.artistsToDelegate.count < 3 {
                            self.artistsToDelegate.append(artista)
                            
                        }
                        
                        if self.artistsToDelegate.count == 3 {
                            guard let artistViewReference = UINib(nibName: "ArtistsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ArtistsView else { return }
                            artistViewReference.delegate = self
                            self.contentStackView.addArrangedSubview(artistViewReference)
                            artistViewReference.configure(self.artistsToDelegate)
                            
                            artistViewReference.translatesAutoresizingMaskIntoConstraints = false
                            artistViewReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
                            artistViewReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
                            
                            self.artistsToDelegate = []
                            self.numberOfCells += 1
                        }
                    }
                }
                
                if self.artistsToDelegate.count > 0 && numberOfCells < 2 {
                    guard let artistViewReference = UINib(nibName: "ArtistsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ArtistsView else { return }
                    artistViewReference.delegate = self
                    self.contentStackView.addArrangedSubview(artistViewReference)
                    artistViewReference.configure(self.artistsToDelegate)
                }
                
                if film.atores.count > 6 {
                    guard let seeAllViewReference = UINib(nibName: "SeeAllView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? SeeAllView else { return }
                    seeAllViewReference.delegate = self
                    
                    self.contentStackView.addArrangedSubview(seeAllViewReference)
                    
                    seeAllContent = .actors
                }
                
            } else if let _ = serie {
                for artista in serie.atores {
                    if self.numberOfCells < 2 {
                        if self.artistsToDelegate.count < 3 {
                            self.artistsToDelegate.append(artista)
                            
                        } else if self.artistsToDelegate.count == 3 {
                            guard let artistViewReference = UINib(nibName: "ArtistsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ArtistsView else { return }
                            artistViewReference.delegate = self
                            self.contentStackView.addArrangedSubview(artistViewReference)
                            artistViewReference.configure(self.artistsToDelegate)
                            
                            artistViewReference.translatesAutoresizingMaskIntoConstraints = false
                            artistViewReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
                            artistViewReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
                            
                            self.artistsToDelegate = [artista]
                            self.numberOfCells += 1
                        }
                    }
                }
                
                if self.artistsToDelegate.count > 0 {
                    guard let artistViewReference = UINib(nibName: "ArtistsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ArtistsView else { return }
                    artistViewReference.delegate = self
                    self.contentStackView.addArrangedSubview(artistViewReference)
                    artistViewReference.configure(self.artistsToDelegate)
                }
                
                if serie.atores.count > 6 {
                    guard let seeAllViewReference = UINib(nibName: "SeeAllView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? SeeAllView else { return }
                    seeAllViewReference.delegate = self
                    
                    self.contentStackView.addArrangedSubview(seeAllViewReference)
                    
                    seeAllContent = .actors
                }
            }
            
            
            break
            
        case 1:
            //ABA REVIEW SELECIONADA
            for (index, subview) in contentStackView.arrangedSubviews.enumerated() {
                if index >= 2 {
                    subview.removeFromSuperview()
                }
            }
            
            numberOfCells = 0
            
            if let _ = self.film {
                for review in film.avaliacoes {
                    if self.numberOfCells < 5 {
                        guard let viewReviewTypeReference = UINib(nibName: "ViewReviewType", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ViewReviewType else { return }
                        viewReviewTypeReference.delegate = self
                        self.contentStackView.addArrangedSubview(viewReviewTypeReference)
                        viewReviewTypeReference.configure(review, index: numberOfCells)
                        
                        viewReviewTypeReference.translatesAutoresizingMaskIntoConstraints = false
                        viewReviewTypeReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
                        viewReviewTypeReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
                        
                        self.numberOfCells += 1
                    }
                }
                
                if film.avaliacoes.count > 5 {
                    guard let seeAllViewReference = UINib(nibName: "SeeAllView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? SeeAllView else { return }
                    seeAllViewReference.delegate = self
                    
                    self.contentStackView.addArrangedSubview(seeAllViewReference)
                    
                    seeAllContent = .reviews
                }
                
            } else {
                for review in serie.avaliacoes {
                    if self.numberOfCells <= 5 {
                        guard let viewReviewTypeReference = UINib(nibName: "ViewReviewType", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ViewReviewType else { return }
                        viewReviewTypeReference.delegate = self
                        self.contentStackView.addArrangedSubview(viewReviewTypeReference)
                        viewReviewTypeReference.configure(review, index: numberOfCells)
                        
                        viewReviewTypeReference.translatesAutoresizingMaskIntoConstraints = false
                        viewReviewTypeReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
                        viewReviewTypeReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
                        
                        self.numberOfCells += 1
                    }
                }
                
                if serie.avaliacoes.count > 5 {
                    guard let seeAllViewReference = UINib(nibName: "SeeAllView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? SeeAllView else { return }
                    seeAllViewReference.delegate = self
                    
                    self.contentStackView.addArrangedSubview(seeAllViewReference)
                    
                    seeAllContent = .reviews
                }
            }
            
            break
            
        case 2:
            //ABA MORE SELECIONADA
            var categoriaToSearch: String!
            
            for (index, subview) in contentStackView.arrangedSubviews.enumerated() {
                if index >= 2 {
                    subview.removeFromSuperview()
                }
            }
            
            numberOfCells = 0
            contentMoreLoaded = 0
            
            guard let loadingViewReference = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? LoadingView else { return }
            contentStackView.addArrangedSubview(loadingViewReference)
            
            loadingViewReference.translatesAutoresizingMaskIntoConstraints = false
            loadingViewReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
            loadingViewReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
            
            if let _ = film {
                categoriaToSearch = film.categorias[0]
            } else {
                categoriaToSearch = serie.categorias[0]
            }
            
            if contentMoreLoaded == 0 || contentMoreLoaded == 2 {
                //Request todos filmes
                FilmsSever.takeAllFilms { allFilms in
                    if let todosFilmes = allFilms {
                        loadingViewReference.removeFromSuperview()
                        
                        for film in todosFilmes {
                            if self.numberOfCells <= 5 {
                                for categoria in film.categorias {
                                    if categoria == categoriaToSearch && film.identifier != self.film.identifier {
                                        guard let recommendedMovieViewReference = UINib(nibName: "RecommendedMovieView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? RecommendedMovieView else { return }
                                        self.contentStackView.addSubview(recommendedMovieViewReference)
                                        recommendedMovieViewReference.delegate = self
                                        recommendedMovieViewReference.configure(film, nil)
                                        self.numberOfCells += 1
                                    }
                                }
                            }
                        }
                        self.contentMoreLoaded += 1
                    } else {
                            print("Erro - Request de todos os filmes retornou nil")
                        }
                    }
                
            }
            
            if contentMoreLoaded < 2 {
                //Request todas series
                SeriesServer.takeAllSeries { allSeries in
                    
                    if let todasSeries = allSeries {
                        loadingViewReference.removeFromSuperview()
                        
                        for serie in todasSeries {
                            if self.numberOfCells <= 5 {
                                for categoria in serie.categorias {
                                    if categoria == categoriaToSearch && serie.identifier != self.serie.identifier {
                                        guard let recommendedMovieViewReference = UINib(nibName: "RecommendedMovieView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? RecommendedMovieView else { return }
                                        self.contentStackView.addArrangedSubview(recommendedMovieViewReference)
                                        recommendedMovieViewReference.delegate = self
                                        recommendedMovieViewReference.configure(nil, serie)
                                        self.numberOfCells += 1
                                    }
                                }
                            }
                        }
                        self.contentMoreLoaded += 2
                    } else {
                        print("Erro - Request de todos as séries retornou nil")
                    }
                }
            }
            break
            
        default:
            break
            
        }
        
    }
    
    private func playVideo() {
        
        runningVideo = true
        
        let player = AVPlayer(url: trailer!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            
            playerViewController.player!.play()
            
        }
        
    }
    
}

//Atendendo ao protocolo ReviewViewDelegate
extension MovieDetailsViewController: ReviewViewDelegate {
    func didPressLikeButton(atIndex index: Int?) {
        guard let index = index else { return }
        
        var reviewChanged: Review
        
        if let _ = self.film {
            reviewChanged = film.avaliacoes[index + 1]
            reviewChanged.userLike = !reviewChanged.userLike
            film.avaliacoes[index + 1] = reviewChanged
            
        } else {
            reviewChanged = serie.avaliacoes[index + 1]
            reviewChanged.userLike = !reviewChanged.userLike
            serie.avaliacoes[index + 1] = reviewChanged
            
        }
        
        segmentedBar.selectedSegmentIndex = 1
        indexChanged(segmentedBar)
        
        ReviewsServer.updateReview(reviewChanged) { success in
            if success == false {
                //TRATAR O ERRO POIS A ATUALIZACAO DA REVIEW NAO OBTEVE SUCESSO
            }
        }
    }
}

//Atendendo ao protocolo ArtistViewDelegate
extension MovieDetailsViewController: ArtistViewDelegate {
    func artistPressed(_ artista: Artist) {
        if let artistDetailViewController = storyboard?.instantiateViewController(withIdentifier: "artistDetailsVC") as? ArtistDetailsViewController {
            
            artistDetailViewController.clickedartistId = artista.identifier
            navigationController?.pushViewController(artistDetailViewController, animated: true)
            artistDetailViewController.backWithColor = .white
            
        }
    }
}

//Atendendo ao protocolo SeeAllButtonClicked
extension MovieDetailsViewController: SeeAllButtonClicked {
    func seeAllClicked(index: Int?) {
        guard let allReviewsActorsReference = storyboard?.instantiateViewController(withIdentifier: "allRAVC") as? AllReviewsAndActors else { return }
        
        if seeAllContent == .reviews {
            if let _ = film {
                allReviewsActorsReference.reviews = film.avaliacoes
            } else {
                allReviewsActorsReference.reviews = serie.avaliacoes
            }
        } else {
            if let _ = film {
                allReviewsActorsReference.actors = film.atores
            } else {
                allReviewsActorsReference.actors = serie.atores
            }
        }
        
        allReviewsActorsReference.movieDetails = self
        
        navigationController?.pushViewController(allReviewsActorsReference, animated: true)
    }
}

//Atendendo ao protocolo MovieClicked
extension MovieDetailsViewController: MovieClicked {
    func cellClicked(film: Film?, serie: Serie?) {
        if let _ = film {
            guard let movieDetailsReference = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController else { return }
            movieDetailsReference.idToRequest = film?.identifier
            movieDetailsReference.requestType = .filme
            movieDetailsReference.backWithColor = .white
            navigationController?.pushViewController(movieDetailsReference, animated: true)
        } else {
            guard let movieDetailsReference = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController else { return }
            movieDetailsReference.idToRequest = serie?.identifier
            movieDetailsReference.requestType = .serie
            movieDetailsReference.backWithColor = .white
            navigationController?.pushViewController(movieDetailsReference, animated: true)
        }
    }
}
