import Foundation
import UIKit

class ListOfGenre: UIViewController {
    @IBOutlet weak var listFilmsTableView: FilmList!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        //DELETAR COM IMPLEMENTACAO DE BACKEND
        listFilmsTableView.dataSource = self
        listFilmsTableView.delegate = self
        //DELETAR COM IMPLEMENTACAO DE BACKEND
        
    }
    
}

extension ListOfGenre: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //DELETAR COM IMPLEMENTACAO DE BACKEND
        return 3
        //DELETAR COM IMPLEMENTACAO DE BACKEND
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? CellMoviesType else {
            
            print("Erro - Retornando célula não configurada")
            return UITableViewCell()
            
        }
        
        //DELETAR COM IMPLEMENTACAO DE BACKEND
        cell.movieImage.sd_setImage(with: URL(string: "https://i.pinimg.com/originals/9d/87/c8/9d87c80d0a7a49c519a504b855d9113d.jpg")!, completed: nil)
        cell.movieCategories.text = "Genero | Genero | Genero"
        cell.movieName.text = "TESTE FILME"
        
        if let starBarViewReference = UINib(nibName: "StarBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? StarBarView  {
            
            cell.stars.addSubview(starBarViewReference)
            starBarViewReference.fillStars(2)
            
        }
        //DELETAR COM IMPLEMENTACAO DE BACKEND
        
        return cell
        
    }
    
}

extension ListOfGenre: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //CHAMAR TELA DE FILM DETAILS
        //ENVIAR UM FILME (O QUE DEVERA APARECER NO FILM DETAILS)
        
    }
    
}
