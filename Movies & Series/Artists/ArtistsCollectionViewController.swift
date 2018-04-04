import Foundation
import UIKit
import SDWebImage

//DELETAR COM BANCO DE DADOS
var artistNames = ["Blake Lively", "TESTE TESTE TESTE TESTE TESTE TESTE TESTE", "TESTE 3"]
var imageTeste: URL = URL(string: "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAHQAugMBIgACEQEDEQH/xAAbAAADAQEAAwAAAAAAAAAAAAACAwQBAAUGB//EACcQAQEBAAEDAwQBBQAAAAAAAAACARIDEWEFBiEEMZPSQRMUJDRU/8QAGAEBAQEBAQAAAAAAAAAAAAAAAgEDAAT/xAAXEQEBAQEAAAAAAAAAAAAAAAAAAREx/9oADAMBAAIRAxEAPwD5VJ8YVGHw9ceOmxh8YVGHxjSM6bGKIwrp4ojDjOmRJ0SCMOnGkZ1syZkunDMwpAtDkt4jzHdlxC9kOzh3YO45YRUlVKmsKvEKJbwi8VXhN4zpxJeJ7xXeJrZ1pE14ReKbT1gVpCLLNsANNMg+CIPhYNUQfBEKOm0jOn9NTCeFEfZpGVOjD5Jg+WkZ0ycHmBkeHAE5zXOZoNHrNc4rcKvDqJoaUIsi1Fk9QKcTWm6im09s60iayLUWntnWsIss2/sWJjg+E8afGuiVTCjppY1RGtIzqrpnwm6eqI1pGdUQfOp40+d+GkZ06TM0qfsOdKBhmOD38u7+VQQN1vfyHUUNFUPdKpFhdp7069IsK0hNp7OtPes60hNp7OvSLZ1pCbLHYBPBQdGp506NSOqmFEJY0+NaQLFUao6epI0+KaRnYrnTp1LFHTRys7FOaOdTzRmUYYd3b3KyvLuTtTDd0O0DaDtOdja0utZVF1SUpA3pF6O6IumdaSF3pF6ZekXoVpIXep7NvSL1nThdgbegDWjZ02NInTJ10dVMafFJZ06KOBVcUdFI4o+KOVnYrmjppHNmzZyhYrmzMtLNjyy0cU8nck/NvNdTD+YdorbDtu12Dqi6sO2VVjaUjbom6dVlXQWnIy6IvRXRN0FOQF0VWirSa0bTkDWg7trQdwN06ZOkZpk66OqidNmk2aZNFKNiuaNmkk0bNEFiuaMm0k0ZlnKNiubHl/KSaHlro4p5t5+U3NvNdTFG35Dtkc2bbtXDdsuqL2wVQ6sg6oqqDVl1SWlI2qJum1RVUFp4yqKrW7pe6OlGVoG1oO4k7BzpOaPNTVp86PKIzR5paNijKMmvhNlDyi1MVZXkeWlyh5S6NirK8iy0uWPLXRxRzdzI5u5rqYfzZtk82c3auG7YKryXtg201cHVAqgbQNpLVkFVF1TNoG6BRu0Xuu3QbqFI7dYzdZ3TVYLHOSKPBY1xDRYPHOVBYPHOWIJuOcqVrnOVHM3WOc5n8M1zkWA0OuchA15b2p9B9N6l6xn0/wBZG30v6N3xytn5zt2+c+f5c4as69y32h6H9v7Ovz9T9i99o+if8lfn6n7OcDSM32j6H2/06/P1P2Pn2b6D2z/Cr8/U/ZzkV//Z")!
//DELETAR COM BANCO DE DADOS

class ArtistsViewController: UIViewController {
    //ATUALIZAR COM O BANCO DE DADOS
        //VAR NAMEARTISTS = [STRING]
        //VAR IMAGEARTISTS = [URL]
    //ATUALIZAR COM O BANCO DE DADOS
    
    @IBOutlet weak var artistsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistsCollectionView.dataSource = self
        artistsCollectionView.delegate = self
    }
}

//ATENDENDO AO PROTOCOLO UICOLLECTIONVIEWDATASOURCE
extension ArtistsViewController: UICollectionViewDataSource {
    
    //DEFININDO NUMERO DE SECOES
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //DEFININDO NUMERO DE ITENS EM DETERMINADA SECAO
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return artistNames.count
    }
    
    //CUSTOMIZANDO E ENVIANDO A CELULA PARA DETERMINADO ITEM
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCollectionViewCell.identifier, for: indexPath) as? ArtistsCollectionViewCell else {
            print("Erro - Retornando célula não configurada")
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 6
        cell.artistImage.sd_setImage(with: imageTeste, completed: nil)
        cell.artistName.text = artistNames[indexPath.item]
        return cell
    }
}

//ATENDENDO AO PROTOCOLO UICOLLECTIONVIEWDELEGATE
extension ArtistsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Voce selecionou a célula \(indexPath.item)!")
    }
}
