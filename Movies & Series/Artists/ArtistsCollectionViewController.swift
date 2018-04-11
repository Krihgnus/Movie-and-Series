import Foundation
import UIKit
import SDWebImage

class ArtistsViewController: UIViewController {
    
    @IBOutlet weak var artistsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var todosArtistas: [Artist] = []
    private var contentLoad = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistsCollectionView.dataSource = self
        artistsCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Request
        if contentLoad == 0 {
            activityIndicator.startAnimating()
            ArtistsServer.takeAllArtists { artistasOptional in
                if let artistas = artistasOptional {
                    self.todosArtistas = artistas
                    self.artistsCollectionView.reloadData()
                    self.artistsCollectionView.isHidden = false
                    self.contentLoad = 1
                } else {
                    self.presentNetworkErrorAlert()
                    print("Erro - Nil como resposta do backend")
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
}


//Atendendo ao protocolo UICollectionViewDataSource
extension ArtistsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todosArtistas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCollectionViewCell.identifier, for: indexPath) as? ArtistsCollectionViewCell else {
            print("Erro - Retornando célula não configurada")
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 4
        cell.artistImage.sd_setImage(with: todosArtistas[indexPath.row].imagemCollection, completed: nil)
        cell.artistName.text = todosArtistas[indexPath.row].nome
        return cell
    }
}

//Atendendo ao protocolo UICollectionViewDelegate
extension ArtistsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let artistDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "artistDetailsVC") as? ArtistDetailsViewController {
            navigationController?.pushViewController(artistDetailViewController, animated: true)
            clickedartistId = indexPath.item + 1
        }
    }
}
