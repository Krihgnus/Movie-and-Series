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
    //FAZER OUTLET DA MOVIE DETAILS TABLE VIEW
    var backWithColor: FilmDetailsBackColor!
    var idToRequest: Int!
    var requestType: FilmeSerie!
    var trailer: URL!
    var runningVideo: Bool = false
    
    @IBAction func playVideoButton(_ sender: Any) {
        
        playVideo()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        
        let threePointsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 6))
        threePointsButton.setBackgroundImage(UIImage(imageLiteralResourceName: "threePointsIcon"), for: .normal)
        threePointsButton.setBackgroundImage(UIImage(imageLiteralResourceName: "threePointsIcon"), for: .highlighted)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: threePointsButton)
        
        segmentedBar.clearSegmentedBar()
        segmentedBar.insertSegment(withTitle: "Cast", at: 0, animated: false)
        segmentedBar.insertSegment(withTitle: "Reviews", at: 1, animated: false)
        segmentedBar.insertSegment(withTitle: "More", at: 2, animated: false)
        segmentedBar.selectedSegmentIndex = 0
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        contentView.isHidden = true
        screenActivityIndicator.startAnimating()

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
                    self.mediaAndTotalReviewsLabel.text = "\(film.mediaEstrelas).0  /  \(film.avaliacoes.count)"
                    self.launchLabel.text = "\(Utils.numberToMonth(film.dataLancamento["Mes"])) \(String(film.dataLancamento["Dia"]!)), \(String(film.dataLancamento["Ano"]!) ) (\(film.siglaPaisLancamento)) \(film.duracao)"
                    self.trailer = film.trailer
                    
                    //Implementando pod ExpandableLabel
                    let attributedStringColor = [NSAttributedStringKey.foregroundColor : UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)];
                    self.descriptionLabel.collapsedAttributedLink =  NSAttributedString(string: "show all", attributes: attributedStringColor)
                    self.descriptionLabel.setLessLinkWith(lessLink: "hide", attributes: [.foregroundColor: UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)], position: .left)
                    self.descriptionLabel.shouldCollapse = true
                    self.descriptionLabel.textReplacementType = .word
                    self.descriptionLabel.numberOfLines = 3
                    self.descriptionLabel.text = film.descricao
                    
                    guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
                    starBarCurrentScreen = .noEvaluate
                    self.starsView.translatesAutoresizingMaskIntoConstraints = true
                    self.starsView.frame.size = CGSize(width: 94, height: 15)
                    starBarReference.bounds = self.starsView.bounds
                    self.starsView.addSubview(starBarReference)
                    starBarReference.fillStars(film.mediaEstrelas)
                    
                    self.contentView.isHidden = false
                    self.navigationController?.navigationBar.tintColor = .white
                    (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                    self.screenActivityIndicator.stopAnimating()
                
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
                    self.mediaAndTotalReviewsLabel.text = "\(serie.mediaEstrelas).0  /  \(serie.avaliacoes.count)"
                    self.launchLabel.text = "\(Utils.numberToMonth(serie.dataLancamento["Mes"])) \(String(serie.dataLancamento["Dia"]!)), \(String(serie.dataLancamento["Ano"]!) ) (\(serie.siglaPaisLancamento)) \(serie.nEpisodios) ep / \(serie.duracaoEpisodio) min"
                    self.trailer = serie.trailer
                    
                    //Implementando pod ExpandableLabel
                    let attributedStringColor = [NSAttributedStringKey.foregroundColor : UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)];
                    self.descriptionLabel.collapsedAttributedLink =  NSAttributedString(string: "show all", attributes: attributedStringColor)
                    self.descriptionLabel.setLessLinkWith(lessLink: "hide", attributes: [.foregroundColor: UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)], position: .left)
                    self.descriptionLabel.shouldCollapse = true
                    self.descriptionLabel.textReplacementType = .word
                    self.descriptionLabel.numberOfLines = 3
                    self.descriptionLabel.text = serie.descricao
                    
                    guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
                    starBarCurrentScreen = .noEvaluate
                    self.starsView.translatesAutoresizingMaskIntoConstraints = true
                    self.starsView.frame.size = CGSize(width: 94, height: 15)
                    starBarReference.bounds = self.starsView.bounds
                    self.starsView.addSubview(starBarReference)
                    starBarReference.fillStars(serie.mediaEstrelas)
                    
                    self.contentView.isHidden = false
                    self.navigationController?.navigationBar.tintColor = .white
                    (self.navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
                    self.screenActivityIndicator.stopAnimating()
                    
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
            break
            
        case 1:
            //ABA REVIEW SELECIONADA
            break
            
        case 2:
            //ABA MORE SELECIONADA
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
