import Foundation
import UIKit
import SDWebImage
import AVKit
import ExpandableLabel

enum FilmDetailsBackColor {
    
    case white
    case blue
    
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
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var screenActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieDetailsTableView: FilmList!
    @IBOutlet weak var movieDetailsCollectionView: UICollectionView!
    @IBOutlet weak var contentActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    var backWithColor: FilmDetailsBackColor!
    var idToRequest: Int!
    var requestType: FilmeSerie!
    var trailer: URL!
    var runningVideo: Bool = false
    var film: Film!
    var serie: Serie!
    var contentMoreLoaded = 0
    var contentReviewsLoaded = false
    var artistas: [Artist] = []
    var writeReviewViewControllerReference: WriteReviewViewController!
    let tableViewHeightDefaultAppear: CGFloat = UIScreen.main.bounds.size.height - 531
    
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
        
        movieDetailsTableView.delegate = self
        movieDetailsCollectionView.dataSource = self
        movieDetailsCollectionView.delegate = self
        
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
        
        contentView.isHidden = true
        screenActivityIndicator.startAnimating()
        movieDetailsCollectionView.backgroundColor = UIColor(red: 234, green: 234, blue: 234, alpha: 1.0)

        
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
                    self.descriptionLabel.shouldCollapse = true
                    self.descriptionLabel.textReplacementType = .word
                    self.descriptionLabel.numberOfLines = 3
                    self.descriptionLabel.text = film.descricao
                    
                    guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
                    self.starsView.addSubview(starBarReference)
                    self.starsView.translatesAutoresizingMaskIntoConstraints = true
                    starBarReference.topAnchor.constraint(equalTo: self.starsView.topAnchor, constant: 0).isActive = true
                    starBarReference.bottomAnchor.constraint(equalTo: self.starsView.bottomAnchor, constant: 0).isActive = true
                    starBarReference.leadingAnchor.constraint(equalTo: self.starsView.leadingAnchor, constant: 0).isActive = true
                    starBarReference.trailingAnchor.constraint(equalTo: self.starsView.trailingAnchor, constant: 0).isActive = true
                    starBarReference.fillStars(Utils.reviewsToAverageStar(film.avaliacoes))
                    
                    self.contentView.isHidden = false
                    self.navigationController?.navigationBar.tintColor = .white
                    (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                    self.screenActivityIndicator.stopAnimating()
                    self.artistas = film.atores
                    self.movieDetailsCollectionView.reloadData()
                    self.scrollViewHeight.constant = self.movieDetailsCollectionView.frame.height - self.tableViewHeightDefaultAppear //TESTE
                    self.movieDetailsTableView.reviewsByFilm = film.avaliacoes
                    self.writeReviewViewControllerReference.sendReview = film.avaliacoes[0]
                    self.film = film
                    self.contentReviewsLoaded = true
                    
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
                    
                    self.starsView.translatesAutoresizingMaskIntoConstraints = true
                    starBarReference.topAnchor.constraint(equalTo: self.starsView.topAnchor, constant: 0).isActive = true
                    starBarReference.bottomAnchor.constraint(equalTo: self.starsView.bottomAnchor, constant: 0).isActive = true
                    starBarReference.leadingAnchor.constraint(equalTo: self.starsView.leadingAnchor, constant: 0).isActive = true
                    starBarReference.trailingAnchor.constraint(equalTo: self.starsView.trailingAnchor, constant: 0).isActive = true
                    starBarReference.fillStars(Utils.reviewsToAverageStar(serie.avaliacoes))
                    
                    self.contentView.isHidden = false
                    self.navigationController?.navigationBar.tintColor = .white
                    (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                    self.screenActivityIndicator.stopAnimating()
                    
                    self.artistas = serie.atores
                    self.movieDetailsCollectionView.reloadData()
                    self.scrollViewHeight.constant = self.movieDetailsCollectionView.frame.height - self.tableViewHeightDefaultAppear //TESTE
        
                    self.movieDetailsTableView.reviewsByFilm = serie.avaliacoes
                    self.writeReviewViewControllerReference.sendReview = serie.avaliacoes[0]
                    self.serie = serie
                    self.contentReviewsLoaded = true
                    
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
        
        segmentedBar.selectedSegmentIndex = 0
        indexChanged(segmentedBar)
        
        if contentReviewsLoaded {
            if let _ = self.film {
                if film.avaliacoes[0].identifier != writeReviewViewControllerReference.sendReview.identifier {
                    movieDetailsTableView.reviewsByFilm.append(self.writeReviewViewControllerReference.sendReview)
                }
            } else {
                if serie.avaliacoes[0].identifier != writeReviewViewControllerReference.sendReview.identifier {
                    movieDetailsTableView.reviewsByFilm.append(self.writeReviewViewControllerReference.sendReview)
                }
            }
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
        
        //self.scrollViewHeight.constant = 0 //TESTE
        
        switch segmentedBar.selectedSegmentIndex {
            
        case 0:
            //ABA CAST SELECIONADA
            movieDetailsTableView.isHidden = true
            movieDetailsCollectionView.isHidden = false
            //scrollViewHeight.constant = self.movieDetailsTableView.frame.height - self.tableViewHeightDefaultAppear //TESTE
            
            break
            
        case 1:
            //ABA REVIEW SELECIONADA
            movieDetailsTableView.tbvType = .reviews
            movieDetailsCollectionView.isHidden = true
            movieDetailsTableView.reloadData()
            movieDetailsTableView.isHidden = false
            scrollViewHeight.constant = self.movieDetailsTableView.frame.height - self.tableViewHeightDefaultAppear //TESTE
    
            break
            
        case 2:
            //ABA MORE SELECIONADA
            movieDetailsCollectionView.isHidden = true
            movieDetailsTableView.isHidden = true
            var categoriaToSearch: String!
            movieDetailsTableView.tbvType = .movies
            contentActivityIndicator.startAnimating()
            movieDetailsTableView.rowHeight = 200
            
            if let _ = film {
                categoriaToSearch = film.categorias[0]
            } else {
                categoriaToSearch = serie.categorias[0]
            }
            
            if contentMoreLoaded == 0 || contentMoreLoaded == 2 {
                //Request todos filmes
                FilmsSever.takeAllFilms { allFilms in
                    
                    if let todosFilmes = allFilms {
                        
                        for film in todosFilmes {
                            for categoria in film.categorias {
                                if categoria == categoriaToSearch {
                                    self.movieDetailsTableView.filmsByArtist.append(film)
                                }
                            }
                            
                            if let _ = self.film {
                                if self.film.identifier == film.identifier {
                                    self.movieDetailsTableView.filmsByArtist.removeLast()
                                }
                            }
                        
                        }
                        
                        self.movieDetailsTableView.reloadData()
                        self.contentMoreLoaded += 1
                        
                        if self.contentMoreLoaded == 3 {
                            self.contentActivityIndicator.stopAnimating()
                            self.movieDetailsTableView.isHidden = false
                            self.scrollViewHeight.constant = self.movieDetailsTableView.frame.height - self.tableViewHeightDefaultAppear //TESTE
                        }
                        
                    } else {
                        print("Erro - Request de todos os filmes retornou nil")
                    }
                    
                }
                
            }
            
        if contentMoreLoaded < 2 {
            //Request todas series
            SeriesServer.takeAllSeries { allSeries in
                
                if let todasSeries = allSeries {
                    
                    for serie in todasSeries {
                        for categoria in serie.categorias {
                            if categoria == categoriaToSearch {
                                self.movieDetailsTableView.seriesByArtist.append(serie)
                            }
                        }
                        
                        if let _ = self.serie {
                            if self.serie.identifier == serie.identifier {
                                self.movieDetailsTableView.seriesByArtist.removeLast()
                            }
                        }
                    }
                    
                    self.movieDetailsTableView.reloadData()
                    self.contentMoreLoaded += 2
                    
                    if self.contentMoreLoaded == 3 {
                        self.contentActivityIndicator.stopAnimating()
                        self.movieDetailsTableView.isHidden = false
                        self.scrollViewHeight.constant = self.movieDetailsTableView.frame.height - self.tableViewHeightDefaultAppear //TESTE
                    }
                    
                } else {
                    print("Erro - Request de todos as séries retornou nil")
                }
                
            }
            
        }
            
        if self.contentMoreLoaded == 3 {
            self.movieDetailsTableView.isHidden = false
            self.movieDetailsTableView.reloadData()
            self.contentActivityIndicator.stopAnimating()
            self.scrollViewHeight.constant = self.movieDetailsTableView.frame.height - self.tableViewHeightDefaultAppear //TESTE
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

//Atendendo ao protocolo UITableViewDelegate
extension MovieDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if movieDetailsTableView.tbvType == .movies {
            
            if let movieDetailsReference = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController {
                
                if indexPath.row < movieDetailsTableView.filmsByArtist.count {
                    
                    movieDetailsReference.idToRequest = movieDetailsTableView.filmsByArtist[indexPath.row].identifier
                    movieDetailsReference.requestType = .filme
                    
                } else {
                    
                    movieDetailsReference.idToRequest = movieDetailsTableView.seriesByArtist[indexPath.row - movieDetailsTableView.filmsByArtist.count].identifier
                    movieDetailsReference.requestType = .serie
                    
                }
                
                movieDetailsReference.backWithColor = .white
                navigationController?.pushViewController(movieDetailsReference, animated: true)
                
            }
            
        }
        
    }
    
}

//Atendendo ao protocolo UICollectionViewDataSource
extension MovieDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return artistas.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistsCVC", for: indexPath) as? ArtistsCollectionViewCell else {
            
            print("Erro - Retornando célula não configurada")
            return UICollectionViewCell()
            
        }
        
        cell.layer.cornerRadius = 4
        cell.artistImage.sd_setImage(with: artistas[indexPath.row].imagemCollection, completed: nil)
        cell.artistName.text = artistas[indexPath.row].nome
        return cell
        
    }
    
}

//Atendendo ao protocolo UICollectionViewDelegate
extension MovieDetailsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let artistDetailViewController = storyboard?.instantiateViewController(withIdentifier: "artistDetailsVC") as? ArtistDetailsViewController {
            
            artistDetailViewController.clickedartistId = artistas[indexPath.row].identifier
            navigationController?.pushViewController(artistDetailViewController, animated: true)
            artistDetailViewController.backWithColor = .white
            
        }
        
    }
    
}
