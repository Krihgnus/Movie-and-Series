import Foundation
import UIKit
import SDWebImage


class PhotoAlbumViewController: UIViewController {
    @IBOutlet weak var albumTableView: UITableView!
    
    var albuns: [PhotoAlbum] = []
    var actRowInTableView = 0
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumTableView.dataSource = self
        albumTableView.separatorStyle = .none
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width * 0.245, height: UIScreen.main.bounds.size.width * 0.245)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.tintColor = .white
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
    }
}

//MARK: UiTableViewDataSource

extension PhotoAlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albuns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        actRowInTableView = indexPath.row
        
        if let tableViewCellReference = tableView.dequeueReusableCell(withIdentifier: "albunsTVCell") as? AlbunsTableViewCell {
            let month = Array(Utils.numberToMonth(albuns[indexPath.row].data["Mes"]!))
            let initials = "\(month[0])\(month[1])\(month[2])"
            
            tableViewCellReference.names.text = "\(albuns[indexPath.row].fotografado) - Photoshoot for \(albuns[indexPath.row].fotografo)"
            tableViewCellReference.dateAndLocation.text = "\(initials) \(albuns[indexPath.row].data["Dia"]!), \(albuns[indexPath.row].data["Ano"]!) | \(albuns[indexPath.row].local["Estado"]!), \(albuns[indexPath.row].local["Pais"]!)"
            
            albumTableView.rowHeight = 64
            if albuns[indexPath.row].fotos.count > 4 {
                albumTableView.rowHeight += ((UIScreen.main.bounds.size.width * 0.245) * ((CGFloat(albuns[indexPath.row].fotos.count / 4)) + 1))
            } else {
                albumTableView.rowHeight += ((UIScreen.main.bounds.size.width * 0.245))
            }
            
            tableViewCellReference.albunsCollectionView.dataSource = self
            tableViewCellReference.albunsCollectionView.collectionViewLayout = layout
            tableViewCellReference.selectionStyle = .none
            
            return tableViewCellReference
        }
        
        return UITableViewCell()
    }
}

//MARK: UICollectionViewDataSource

extension PhotoAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albuns[actRowInTableView].fotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCellReference = collectionView.dequeueReusableCell(withReuseIdentifier: "albunsCVCell", for: indexPath) as? AlbunsCollectionViewCell else { return UICollectionViewCell() }
        
        collectionViewCellReference.photo.sd_setImage(with: albuns[actRowInTableView].fotos[indexPath.row], completed: nil)
        
        return collectionViewCellReference
    }
}

