import Foundation
import UIKit

class WriteReviewViewController: UIViewController {
    
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var writeTextField: UITextField!
    
    var textInTextField = ""
    var filmReview: Film!
    var serieReview: Serie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeTextField.delegate = self
    
        writeTextField.attributedPlaceholder = NSAttributedString(string: "Write Your Review", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        writeTextField.tintColor = UIColor(red: 2 / 255.0, green: 149 / 255.0, blue: 165 / 255.0, alpha: 1)
        
        guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        starBarCurrentScreen = .evaluate
        starView.addSubview(starBarReference)
        
        let sendButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 21))
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(UIColor(red: 2 / 255.0, green: 149 / 255.0, blue: 165 / 255.0, alpha: 1), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        
        starBarReference.translatesAutoresizingMaskIntoConstraints = false
        starBarReference.topAnchor.constraint(equalTo: starView.topAnchor, constant: 0).isActive = true
        starBarReference.bottomAnchor.constraint(equalTo: starView.bottomAnchor, constant: 0).isActive = true
        starBarReference.leadingAnchor.constraint(equalTo: starView.leadingAnchor, constant: 0).isActive = true
        starBarReference.trailingAnchor.constraint(equalTo: starView.trailingAnchor, constant: 0).isActive = true
        starBarReference.backgroundColor = UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1)
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        navigationController?.navigationBar.tintColor = UIColor(red: 2 / 255.0, green: 149 / 255.0, blue: 165 / 255.0, alpha: 1)
        
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        starBarCurrentScreen = .noEvaluate
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
        navigationController?.navigationBar.tintColor = .white
        self.tabBarController?.tabBar.isHidden = false
    
    }
    
    @objc func sendButtonClicked() {
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        guard let starBarReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        let fillStars: Int = starBarReference.filledStars
        
        var sendReview = Review(nomeUsuario: "Some User", fotoUsuario: URL(string: "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png")!, dataReview: ["Dia": day, "Mes": month, "Ano": year], estrelas: fillStars, tipoFilmeSerie: .filme, filmeSerieIdentifier: 1, comentario: textInTextField, likes: 0, userLike: false)
        
        if var _ = filmReview {
            
            sendReview.tipoFilmeSerie = .filme
            sendReview.filmeSerieIdentifier = filmReview.identifier
            filmReview.avaliacoes.append(sendReview)
            
        } else if var _ = serieReview {
            
            sendReview.tipoFilmeSerie = .serie
            sendReview.filmeSerieIdentifier = serieReview.identifier
            serieReview.avaliacoes.append(sendReview)
            
        }
        
        let alert = UIAlertController(title: "Successfully Added", message: "Thank you. Your review has been successfully added.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        navigationController?.popViewController(animated: true)
        
        self.parent?.present(alert, animated: true, completion: nil)
        
    }
    
}

extension WriteReviewViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textInTextField = writeTextField.text!
        
        return true
        
    }
    
}
