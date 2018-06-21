import Foundation
import UIKit

class WriteReviewViewController: UIViewController {
    
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var writeTextField: UITextField!
    
    var textInTextField = ""
    var starBarReference: StarBarView!
    var filmeSerieId: Int = 0
    var filmSerieType: FilmeSerie!
    var sendReview: Review!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeTextField.delegate = self
    
        writeTextField.attributedPlaceholder = NSAttributedString(string: "Write Your Review", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        writeTextField.tintColor = UIColor(red: 2 / 255.0, green: 149 / 255.0, blue: 165 / 255.0, alpha: 1)
        
        guard let starBar = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView else { return }
        starBarReference = starBar

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
        self.title = "Write a Review"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .default
        navigationController?.navigationBar.tintColor = UIColor(red: 2 / 255.0, green: 149 / 255.0, blue: 165 / 255.0, alpha: 1)
        
        starBarReference.fillStars(1)
        
        writeTextField.text = ""
        writeTextField.becomeFirstResponder()
        starBarCurrentScreen = .evaluate
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
        
        textFieldShouldEndEditing(writeTextField)
        
        ReviewsServer.countReviews { count in
            if let contagem = count {
                self.sendReview.identifier = contagem + 1
            } else {
                //CONFIGURAR ALERTA DE ERRO POIS A REVIEW NAO FOI ADICIONADA COM SUCESSO NO ARRAY DE ALLREVIEWSMOCK
            }
        }
    
        sendReview.nomeUsuario = "You"
        sendReview.fotoUsuario = URL(string: "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png")!
        sendReview.dataReview = ["Dia": day, "Mes": month, "Ano": year]
        sendReview.estrelas = starBarReference.filledStars
        sendReview.comentario = textInTextField
        sendReview.likes = 0
        sendReview.userLike = false
        sendReview.tipoFilmeSerie = filmSerieType
        sendReview.filmeSerieIdentifier = filmeSerieId
        
        ReviewsServer.addReview(sendReview) { success in
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            
            if success {
                alert.title = "Successfully Added"
                alert.message = "Thank you. Your review has been successfully added."
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.navigationController?.popViewController(animated: true)
                self.parent?.present(alert, animated: true, completion: nil)
            } else {
                //CONFIGURAR ALERTA DE ERRO POIS A REVIEW NAO FOI ADICIONADA COM SUCESSO NO ARRAY DE ALLREVIEWSMOCK
                //REMOVER REVIEW DO ACTREVIEWS 
            }
        }
    }
}

extension WriteReviewViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textInTextField = writeTextField.text!
        return true
    }
}
