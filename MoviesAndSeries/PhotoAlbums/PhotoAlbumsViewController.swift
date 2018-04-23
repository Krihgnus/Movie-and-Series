import Foundation
import UIKit

//DELETAR QUANDO FOR FAZER A VIEW
    var artistNamePhotoAlbums = ""
//DELETAR QUANDO FOR FAZER A VIEW
//ADICIONAR QUANDO FOR FAZER A VIEW
    //VAR OTHERALBUMSARTIST: [PHOTOALBUM] - DO ARTISTA ATUAL
//ADICIONAR QUANDO FOR FAZER A VIEW
class PhotoAlbumViewController: UIViewController {
    //DELETAR QUANDO FOR FAZER A VIEW
        @IBOutlet weak var nome: UILabel!
    //DELETAR QUANDO FOR FAZER A VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        //AJUSTAR QUANDO A VIEW FOR CRIADA A PARTIR DO ARRAY DE PHOTOALBUM RECEBIDO
        nome.text = "ALBUM DE FOTOS DE: \(artistNamePhotoAlbums)"
        //AJUSTAR QUANDO A VIEW FOR CRIADA A PARTIR DO ARRAY DE PHOTOALBUM RECEBIDO
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.tintColor = .white
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
    }
}
