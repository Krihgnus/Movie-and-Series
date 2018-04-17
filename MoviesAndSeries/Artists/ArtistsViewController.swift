import Foundation
import UIKit
import SDWebImage

//var fotoArtista = URL(string: "http://casashow.vteximg.com.br/arquivos/ids/232968-1000-1000/384690-AZULEJO-20X20-EXTRA-PISCINA-AZUL-LAGUNA-CX172-ELIANE.jpg?v=635719463921600000")! //DELETAR COM BANCO DE DADOS
//var artista = "NAME TEXT" //var artistas: [Artista : [Dado : Descricao]] = [:] - ATUALIZAR COM BANCO DE DADOS

//class ArtistsViewController: UIViewController {
//
//}

//    @IBOutlet weak var collectionArtists: UICollectionView!
//
//    override func viewDidLoad() {
//        configureCell()
//    }
//
//    private func configureCell() {
//        collectionArtists.dataSource = self
//        collectionArtists.delegate = self
//        collectionArtists.backgroundColor = .white
//        collectionArtists.register(ArtistsCollectionItem.self, forCellWithReuseIdentifier: ArtistsCollectionItem.identifier)
//    }

//extension ArtistsViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1 //artistas.count - ATUALIZAR COM BANCO DE DADOS
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if let collectionItem = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCollectionItem.identifier, for: indexPath) as? ArtistsCollectionItem {
//            collectionItem.artistName.text = artista //ATUALIZAR COM BANCO DE DADOS
//            collectionItem.artistImage.sd_setImage(with: fotoArtista, completed: nil) //ATUALIZAR COM O BANCO DE DADOS
//            collectionItem.backgroundColor = .blue
//            return collectionItem
//        }
//        print("Erro - Retornando Collection View Cell nao configurada")
//        return UICollectionViewCell()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //PREENCHER
//        print (indexPath)
//    }
//}

