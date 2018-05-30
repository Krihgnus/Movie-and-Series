import Foundation
import UIKit
import SDWebImage
import ExpandableLabel

protocol CellReviewTypeDelegate: class {
    func didPressLikeButton(atIndex index: Int?)
}

class CellReviewType: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dateReview: UILabel!
    @IBOutlet weak var starBarView: UIView!
    @IBOutlet weak var comment: ExpandableLabel!
    @IBOutlet weak var likeAmount: UILabel!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    
    weak var delegate: CellReviewTypeDelegate?
    private(set) var cellIndex: Int?
    
    var likes: Int = 0
    var reviewAct: Review!
    var tableView: UITableView!
    
    @IBAction func likeButton(_ sender: UIButton) {
        delegate?.didPressLikeButton(atIndex: cellIndex)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImage.image = nil
        userName.text = nil
        dateReview.text = nil
        comment.text = nil
        likeAmount.text = nil
    }
    
    func configure(_ review: Review) {
        
        likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "unlike"), for: .normal)
        likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "unlike"), for: .highlighted)
        likeButtonOutlet.adjustsImageWhenHighlighted = false
        var mes = Utils.numberToMonth(review.dataReview["Mes"])
        var chars = Array(mes)
        mes = "\(chars[0])\(chars[1])\(chars[2])"

        userImage.sd_setImage(with: review.fotoUsuario, completed: nil)
        userName.text = review.nomeUsuario
        
        dateReview.text = "\(mes) \(review.dataReview["Dia"]!)th \(review.dataReview["Ano"]!)"
        likeAmount.text = "\(review.likes) helpful votes"

        //Implementado ExpandableLabel - ARRUMAR
        let attributedStringColor = [NSAttributedStringKey.foregroundColor : UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)];
        comment.collapsedAttributedLink =  NSAttributedString(string: "show all", attributes: attributedStringColor)
        comment.setLessLinkWith(lessLink: "hide", attributes: [.foregroundColor: UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)], position: .right)
        comment.shouldCollapse = true
        comment.textReplacementType = .word
        comment.numberOfLines = 3
        comment.text = review.comentario
        comment.delegate = self
        comment.collapsed = true
        
        likes = review.likes
        
        selectionStyle = .none
      
        guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        starBarView.addSubview(starBarReference)
        starBarReference.translatesAutoresizingMaskIntoConstraints = false
        starBarReference.topAnchor.constraint(equalTo: starBarView.topAnchor, constant: 0).isActive = true
        starBarReference.bottomAnchor.constraint(equalTo: starBarView.bottomAnchor, constant: 0).isActive = true
        starBarReference.leadingAnchor.constraint(equalTo: starBarView.leadingAnchor, constant: 0).isActive = true
        starBarReference.trailingAnchor.constraint(equalTo: starBarView.trailingAnchor, constant: 0).isActive = true
        starBarReference.fillStars(review.estrelas)
        
        reviewAct = review
        
        likeUnlike()

    }
    
    func setIndex(_ index: Int) {
        cellIndex = index
    }
    
    private func likeUnlike() {
        if reviewAct.userLike {
            likeAmount.text = "\(likes + 1) helpful votes"
            likeAmount.textColor = UIColor(red: 2 / 255, green: 148 / 255, blue: 165 / 255, alpha: 1.0)
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "like"), for: .normal)
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "like"), for: .highlighted)
        } else {
            likeAmount.text = "\(likes) helpful votes"
            likeAmount.textColor = UIColor(red: 74 / 255, green: 74 / 255, blue: 74 / 255, alpha: 1.0)
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "unlike"), for: .normal)
            likeButtonOutlet.setBackgroundImage(UIImage(imageLiteralResourceName: "unlike"), for: .highlighted)
        }
    }
    
}

//Atendendo ao protocolo ExpandableLabelDelegate - ARRUMAR

extension CellReviewType: ExpandableLabelDelegate {
    func willExpandLabel(_ label: ExpandableLabel) {
        tableView.rowHeight -= label.frame.size.height
    }

    func didExpandLabel(_ label: ExpandableLabel) {
         tableView.rowHeight += label.frame.size.height
         tableView.reloadData()
    }

    func willCollapseLabel(_ label: ExpandableLabel) {
        tableView.rowHeight -= label.frame.size.height
    }

    func didCollapseLabel(_ label: ExpandableLabel) {
        tableView.rowHeight += label.frame.size.height
        tableView.reloadData()
    }

}
