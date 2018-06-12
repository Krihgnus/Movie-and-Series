import Foundation
import UIKit

class AllReviewsAndActors: UIViewController {
    @IBOutlet weak var contentStackView: UIStackView!
    
    var reviews: [Review] = []
    var actors: [Artist] = []
    var actorsToDelegate: [Artist] = []
    var movieDetails: MovieDetailsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = " "
        
        contentStackView.arrangedSubviews[0].removeFromSuperview()
        
        if reviews.count > 0 {
            for (idx, review) in reviews.enumerated() {
                guard let viewReviewTypeReference = UINib(nibName: "ViewReviewType", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ViewReviewType else { return }
                viewReviewTypeReference.delegate = self
                self.contentStackView.addArrangedSubview(viewReviewTypeReference)
                viewReviewTypeReference.configure(review, index: idx)
                
                viewReviewTypeReference.translatesAutoresizingMaskIntoConstraints = false
                viewReviewTypeReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
                viewReviewTypeReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
            }
        } else {
            for artista in actors {
                if self.actorsToDelegate.count < 3 {
                    self.actorsToDelegate.append(artista)
                    
                }
                
                if self.actorsToDelegate.count == 3 {
                    guard let artistViewReference = UINib(nibName: "ArtistsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ArtistsView else { return }
                    artistViewReference.delegate = self
                    self.contentStackView.addArrangedSubview(artistViewReference)
                    artistViewReference.configure(self.actorsToDelegate)
                    
                    artistViewReference.translatesAutoresizingMaskIntoConstraints = false
                    artistViewReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
                    artistViewReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
                    
                    self.actorsToDelegate = []
                }
            }
            
            if self.actorsToDelegate.count > 0 {
                guard let artistViewReference = UINib(nibName: "ArtistsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ArtistsView else { return }
                artistViewReference.delegate = self
                self.contentStackView.addArrangedSubview(artistViewReference)
                artistViewReference.configure(self.actorsToDelegate)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParentViewController {
            (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
            navigationController?.navigationBar.tintColor = .white
        }

    }
    
}

extension AllReviewsAndActors: ReviewViewDelegate {
    func didPressLikeButton(atIndex index: Int?) {
        guard let index = index else { return }
        
        var reviewChanged: Review
        
        reviewChanged = reviews[index + 1]
        reviewChanged.userLike = !reviewChanged.userLike
        reviews[index + 1] = reviewChanged
        
        for review in contentStackView.arrangedSubviews {
            review.removeFromSuperview()
        }
        
        ReviewsServer.updateReview(reviewChanged) { success in
            if success == false {
                //TRATAR O ERRO POIS A ATUALIZACAO DA REVIEW NAO OBTEVE SUCESSO
            }
        }
        
        if let _ = movieDetails.film {
            movieDetails.film.avaliacoes[index + 1] = reviewChanged
        } else {
            movieDetails.serie.avaliacoes[index + 1] = reviewChanged
        }
        
        for (idx, review) in reviews.enumerated() {
            guard let viewReviewTypeReference = UINib(nibName: "ViewReviewType", bundle: nil).instantiate(withOwner: nil, options: nil).first as? ViewReviewType else { return }
            viewReviewTypeReference.delegate = self
            self.contentStackView.addArrangedSubview(viewReviewTypeReference)
            viewReviewTypeReference.configure(review, index: idx)
            
            viewReviewTypeReference.translatesAutoresizingMaskIntoConstraints = false
            viewReviewTypeReference.trailingAnchor.constraint(equalTo: self.contentStackView.trailingAnchor).isActive = true
            viewReviewTypeReference.leadingAnchor.constraint(equalTo: self.contentStackView.leadingAnchor).isActive = true
        }
    }
}

extension AllReviewsAndActors: ArtistViewDelegate {
    func artistPressed(_ artista: Artist) {
        if let artistDetailViewController = storyboard?.instantiateViewController(withIdentifier: "artistDetailsVC") as? ArtistDetailsViewController {
            
            artistDetailViewController.clickedartistId = artista.identifier
            artistDetailViewController.backWithColor = .blue
            
            navigationController?.pushViewController(artistDetailViewController, animated: true)
            
        }
    }
}
