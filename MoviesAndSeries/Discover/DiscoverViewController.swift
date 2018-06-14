import Foundation
import UIKit

class DiscoverViewController: UIViewController {
    @IBOutlet weak var discoverTableView: UITableView!
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    
    var mostPopularsFilms: [Film] = []
    var mostRecentFilms: [Film] = []
    var commingSoonFilms: [Film] = []
    
    var mostPopularSeries: [Serie] = []
    var mostRecentSeries: [Serie] = []
    var commingSoonSeries: [Serie] = []
    
    var actRowInTableView = 0
    var contentLoaded = 0
    var higherNumberStars = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoverTableView.dataSource = self
        discoverTableView.rowHeight = 300
        discoverTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        mainActivityIndicator.startAnimating()
        discoverTableView.isHidden = true
        
        //Request all filmes
        FilmsSever.takeAllFilms { todosFilmes in
            
            if let allFilms = todosFilmes {
                
                //Checking most popular film
                for film in allFilms {
                    if Utils.reviewsToAverageStar(film.avaliacoes) > self.higherNumberStars {
                        self.higherNumberStars = Utils.reviewsToAverageStar(film.avaliacoes)
                    }
                }
                
                //Filling in array mostPopularsFilms
                for film in allFilms {
                    if Utils.reviewsToAverageStar(film.avaliacoes) == self.higherNumberStars || Utils.reviewsToAverageStar(film.avaliacoes) == self.higherNumberStars - 1 {
                        self.mostPopularsFilms.append(film)
                    }
                }
                
                //Chacking current date
                let date = Date()
                let calendar = Calendar.current
                let day: Int = calendar.component(.day, from: date)
                let month: Int = calendar.component(.month, from: date)
                let year: Int = calendar.component(.year, from: date)
                
                //Filling in array mostRecentFilms
                for film in allFilms {
                    if film.dataLancamento["Dia"]! < day && film.dataLancamento["Mes"]! == month && film.dataLancamento["Ano"]! == year {
                         self.mostRecentFilms.append(film)
                    } else if film.dataLancamento["Dia"]! == day && film.dataLancamento["Mes"]! == month && film.dataLancamento["Ano"]! == year {
                         self.mostRecentFilms.append(film)
                    } else if film.dataLancamento["Dia"]! > day && film.dataLancamento["Mes"]! == month - 1 && film.dataLancamento["Ano"]! == year {
                         self.mostRecentFilms.append(film)
                    }
                }
                
                //Filling in array commingSoonFilms
                for film in allFilms {
                    if film.dataLancamento["Dia"]! > day && film.dataLancamento["Mes"]! == month && film.dataLancamento["Ano"]! == year {
                        self.commingSoonFilms.append(film)
                    } else if film.dataLancamento["Dia"]! < day && film.dataLancamento["Mes"]! == month + 1 && film.dataLancamento["Ano"]! == year {
                        self.commingSoonFilms.append(film)
                    }
                }
                
                self.contentLoaded += 1
                
                if self.contentLoaded == 2 {
                    self.discoverTableView.reloadData()
                    self.mainActivityIndicator.stopAnimating()
                    self.discoverTableView.isHidden = false
                }
                
            } else {
                //BACKEND RETORNOU NIL
            }
        }
        
        //Request all series
        SeriesServer.takeAllSeries { todasSeries in
            if let allSeries = todasSeries {
                
                //Checking most popular serie
                self.higherNumberStars = 0
                for serie in allSeries {
                    if Utils.reviewsToAverageStar(serie.avaliacoes) > self.higherNumberStars {
                        self.higherNumberStars = Utils.reviewsToAverageStar(serie.avaliacoes)
                    }
                }
                
                //Filling in array mostPopularsSeries
                for serie in allSeries {
                    if Utils.reviewsToAverageStar(serie.avaliacoes) == self.higherNumberStars || Utils.reviewsToAverageStar(serie.avaliacoes) == self.higherNumberStars - 1 {
                        self.mostPopularSeries.append(serie)
                    }
                }
                
                //Chacking current date
                let date = Date()
                let calendar = Calendar.current
                let day: Int = calendar.component(.day, from: date)
                let month: Int = calendar.component(.month, from: date)
                let year: Int = calendar.component(.year, from: date)
                
                //Filling in array mostRecentSeries
                for serie in allSeries {
                    if serie.dataLancamento["Dia"]! < day && serie.dataLancamento["Mes"]! == month && serie.dataLancamento["Ano"]! == year {
                        self.mostRecentSeries.append(serie)
                    } else if serie.dataLancamento["Dia"]! == day && serie.dataLancamento["Mes"]! == month && serie.dataLancamento["Ano"]! == year {
                        self.mostRecentSeries.append(serie)
                    } else if serie.dataLancamento["Dia"]! > day && serie.dataLancamento["Mes"]! == month - 1 && serie.dataLancamento["Ano"]! == year {
                        self.mostRecentSeries.append(serie)
                    }
                }
                
                //Filling in array commingSoonSeries
                for serie in allSeries {
                    if serie.dataLancamento["Dia"]! > day && serie.dataLancamento["Mes"]! == month && serie.dataLancamento["Ano"]! == year {
                        self.commingSoonSeries.append(serie)
                    } else if serie.dataLancamento["Dia"]! < day && serie.dataLancamento["Mes"]! == month + 1 && serie.dataLancamento["Ano"]! == year {
                        self.commingSoonSeries.append(serie)
                    }
                }
                
                self.contentLoaded += 1
                
                if self.contentLoaded == 2 {
                    self.discoverTableView.reloadData()
                    self.mainActivityIndicator.stopAnimating()
                    self.discoverTableView.isHidden = false
                }
                
            } else {
                //BACKEND RETORNOU NIL
            }
        }
    }
}

//MARK: UITableViewDataSource

extension DiscoverViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        actRowInTableView = indexPath.row
        
        switch indexPath.row {
        case 0:
            if let tableViewCellReference = tableView.dequeueReusableCell(withIdentifier: "discoverTVCell") as? DiscoverTableViewCell {
                tableViewCellReference.delegate = self
                
                tableViewCellReference.seeAllButtonOutlet.isHidden = false
                if mostPopularsFilms.count + mostPopularSeries.count <= 3 {
                    tableViewCellReference.seeAllButtonOutlet.isHidden = true
                }
                
                tableViewCellReference.topicLabel.text = "Most Popular"
                tableViewCellReference.collectionView.dataSource = self
                tableViewCellReference.collectionView.reloadData()
                return tableViewCellReference
            }
        case 1:
            if let tableViewCellReference = tableView.dequeueReusableCell(withIdentifier: "discoverTVCell") as? DiscoverTableViewCell {
                tableViewCellReference.delegate = self
                
                tableViewCellReference.seeAllButtonOutlet.isHidden = false
                if mostRecentFilms.count + mostRecentSeries.count <= 3 {
                    tableViewCellReference.seeAllButtonOutlet.isHidden = true
                }
                
                tableViewCellReference.topicLabel.text = "Most Recent"
                tableViewCellReference.collectionView.dataSource = self	
                tableViewCellReference.collectionView.reloadData()
                return tableViewCellReference
            }
        case 2:
            if let tableViewCellReference = tableView.dequeueReusableCell(withIdentifier: "discoverTVCell") as? DiscoverTableViewCell {
                tableViewCellReference.delegate = self
                
                tableViewCellReference.seeAllButtonOutlet.isHidden = false
                if commingSoonFilms.count + commingSoonSeries.count <= 3 {
                    tableViewCellReference.seeAllButtonOutlet.isHidden = true
                }
                
                tableViewCellReference.topicLabel.text = "Comming Soon"
                tableViewCellReference.collectionView.dataSource = self
                tableViewCellReference.collectionView.reloadData()
                return tableViewCellReference
            }
        default:
                break
        }
        
        return UITableViewCell()
    }
}

//MARK: UICollectionViewDataSource

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch actRowInTableView {
        case 0:
            if mostPopularsFilms.count + mostPopularSeries.count >= 3 {
                return 3
            }
            
            return mostPopularsFilms.count + mostPopularSeries.count
        case 1:
            if mostRecentFilms.count + mostRecentSeries.count >= 3 {
                return 3
            }
            
            return mostRecentFilms.count + mostRecentSeries.count
        case 2:
            if commingSoonFilms.count + commingSoonSeries.count >= 3 {
                return 3
            }
            
            return commingSoonFilms.count + commingSoonSeries.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch actRowInTableView {
        case 0:
            if let collectionViewItemReference = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverCVCell", for: indexPath) as? DiscoverCollectionViewCell {
                if indexPath.row < mostPopularsFilms.count {
                    collectionViewItemReference.delegate = self
                    collectionViewItemReference.configure(film: mostPopularsFilms[indexPath.row], serie: nil)
                } else if indexPath.row - mostPopularsFilms.count < mostPopularSeries.count {
                    collectionViewItemReference.delegate = self
                    collectionViewItemReference.configure(film: nil, serie: mostPopularSeries[indexPath.row - mostPopularsFilms.count])
                }
                
                return collectionViewItemReference
            }
        case 1:
            if let collectionViewItemReference = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverCVCell", for: indexPath) as? DiscoverCollectionViewCell {
                if indexPath.row < mostRecentFilms.count {
                    collectionViewItemReference.delegate = self
                    collectionViewItemReference.configure(film: mostRecentFilms[indexPath.row], serie: nil)
                } else if indexPath.row - mostRecentFilms.count < mostRecentSeries.count {
                    collectionViewItemReference.delegate = self
                    collectionViewItemReference.configure(film: nil, serie: mostRecentSeries[indexPath.row - mostRecentFilms.count])
                }
                
                return collectionViewItemReference
            }
        case 2:
            if let collectionViewItemReference = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverCVCell", for: indexPath) as? DiscoverCollectionViewCell {
                if indexPath.row < commingSoonFilms.count {
                    collectionViewItemReference.delegate = self
                    collectionViewItemReference.configure(film: commingSoonFilms[indexPath.row], serie: nil)
                } else if indexPath.row - commingSoonFilms.count < commingSoonSeries.count {
                    collectionViewItemReference.delegate = self
                    collectionViewItemReference.configure(film: nil, serie: commingSoonSeries[indexPath.row - commingSoonFilms.count])
                }
                
                return collectionViewItemReference
            }
        default:
           break
        }
        return UICollectionViewCell()
    }
}

//MARK: SeeAllButtonClicked (UITableViewCellDelegate)

extension DiscoverViewController: SeeAllButtonClicked {
    func seeAllClicked(index: Int?) {
        guard let filmListReference = storyboard?.instantiateViewController(withIdentifier: "listOfFIlmsVC") as? ListOfFilms else { return }
        
        switch index {
        case 0:
            filmListReference.genreFilms = mostPopularsFilms
            filmListReference.genreSeries = mostRecentSeries
        case 1:
            filmListReference.genreFilms = mostRecentFilms
            filmListReference.genreSeries = mostRecentSeries
        case 2:
            filmListReference.genreFilms = commingSoonFilms
            filmListReference.genreSeries = commingSoonSeries
        default:
            break
        }
        
        filmListReference.backWithColor = .blue
        navigationController?.pushViewController(filmListReference, animated: true)
    }
    
}

//MARK: MovieClicked (UICollectionViewDelegate)

extension DiscoverViewController: MovieClicked {
    func cellClicked(film: Film?, serie: Serie?) {
        guard let movieDetailsReference = storyboard?.instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController else { return }
        if let _ = film {
            movieDetailsReference.idToRequest = film?.identifier
            movieDetailsReference.requestType = .filme
        } else if let _ = serie {
            movieDetailsReference.idToRequest = serie?.identifier
            movieDetailsReference.requestType = .serie
        }
        
        movieDetailsReference.backWithColor = .blue
        navigationController?.pushViewController(movieDetailsReference, animated: true)
    }
}



