import Foundation
import UIKit
import SDWebImage

protocol ReviewViewDelegate: class {
    func didPressLikeButton(atIndex index: Int?)
}

class ViewReviewType: UIView {
    
    static let identifier = "reviewView"
    var userLike: Bool!
    var viewIndexInStackView: Int = 0
    var rowReview: Review!
    
    weak var delegate: ReviewViewDelegate?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var starBarView: UIView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    
    @IBAction func likeButton(_ sender: UIButton) {
        delegate?.didPressLikeButton(atIndex: viewIndexInStackView)
    }
    
    func configure(_ review: Review, index: Int) {
        
        let mes = Array(Utils.numberToMonth(review.dataReview["Mes"]))
        let siglaMes: String = "\(mes[0])\(mes[1])\(mes[2])"
        
        userImage.sd_setImage(with: review.fotoUsuario, completed: nil)
        userName.text = review.nomeUsuario
        reviewDate.text = "\(siglaMes) \(review.dataReview["Dia"] ?? 00)th \(review.dataReview["Ano"] ?? 0000)"
        userLike = review.userLike
        viewIndexInStackView = index - 1
        self.rowReview = review
        
        guard let starBarViewReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        starBarView.addSubview(starBarViewReference)
        starBarViewReference.fillStars(review.estrelas)
        
        if review.userLike {
            likesCount.text = "\(review.likes + 1) helpful votes"
            likesCount.textColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "like"), for: .normal)
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "like"), for: .highlighted)
        } else {
            likesCount.text = "\(review.likes) helpful votes"
            likesCount.textColor = .black
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "unlike"), for: .normal)
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "unlike"), for: .highlighted)
        }
        
        //CONFIGURAR O COMMENT
    }
    
}
