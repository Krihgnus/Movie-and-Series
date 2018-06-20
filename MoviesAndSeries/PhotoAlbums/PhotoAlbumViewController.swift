import Foundation
import UIKit
import SDWebImage


class PhotoAlbumViewController: UIViewController {
    @IBOutlet weak var albumTableView: UITableView!
    
    var albuns: [PhotoAlbum] = []
    var currentTableViewCell = 0
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigation()
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.tintColor = .white
        (navigationController as? CustomNavigationController)?.overridenPreferredStatusBarStyle = .lightContent
    }
    
    func setupLayout() {
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width * 0.245, height: UIScreen.main.bounds.size.width * 0.245)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.tintColor = UIColor(red: 2/255.0, green: 148/255.0, blue: 165/255.0, alpha: 1.0)
        self.title = "Photo Album"
    }
    
    func setupTableView() {
        albumTableView.dataSource = self
        albumTableView.separatorStyle = .none
    }
    
    func takecollectionViewHeight(_ album: PhotoAlbum) -> CGFloat {
        var height: CGFloat = 64
        
        if album.fotos.count > 4 {
            height += ((UIScreen.main.bounds.size.width * 0.245) * ((CGFloat(album.fotos.count / 4)) + 1))
        } else {
            height += ((UIScreen.main.bounds.size.width * 0.245))
        }
        
        return height
    }
}

//MARK: UiTableViewDataSource

extension PhotoAlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albuns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentTableViewCell = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albunsTVCell") as? AlbunsTableViewCell else { return UITableViewCell() }
        cell.albunsCollectionView.dataSource = self
        cell.albunsCollectionView.collectionViewLayout = layout
        cell.configure(albuns[indexPath.row])
        albumTableView.rowHeight = takecollectionViewHeight(albuns[indexPath.row])
        return cell
    }
}

//MARK: UICollectionViewDataSource

extension PhotoAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albuns[currentTableViewCell].fotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albunsCVCell", for: indexPath) as? AlbunsCollectionViewCell else { return UICollectionViewCell() }
        cell.photo.sd_setImage(with: albuns[currentTableViewCell].fotos[indexPath.row], completed: nil)
        return cell
    }
}
