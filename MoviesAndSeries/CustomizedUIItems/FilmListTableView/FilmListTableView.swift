import Foundation
import UIKit

enum TableViewType {
    
    case summary
    case movies
    case more
    
}

class FilmList: UITableView {
    
    var tbvType: TableViewType = .summary
    var artistToTableView: Artist!
    var seriesByArtist: [Serie] = []
    var filmsByArtist: [Film] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1.0)
        
    }
    
}

extension FilmList: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tbvType {
            
        case .summary:
            return 1
            
        case .movies:
            return filmsByArtist.count + seriesByArtist.count
            
        case .more:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tbvType {
            
        case .summary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell") as? CellSummaryType else {
                
                print("Erro - Retornando célula não configurada")
                return UITableViewCell()
                
            }
            
            if artistToTableView == nil {
                
                return UITableViewCell()
                
            }
            
            cell.configure(artistToTableView)
            return cell
            
        case .movies:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? CellMoviesType else {
                
                print("Erro - Retornando célula não configurada")
                return UITableViewCell()
                
            }
            
            if filmsByArtist.count + seriesByArtist.count == 0 {
                
                return UITableViewCell()
            
            } else if indexPath.row < filmsByArtist.count {
                
                cell.configureFilm(filmsByArtist[indexPath.row])
                
            } else {
                
                cell.configureSerie(seriesByArtist[indexPath.row - filmsByArtist.count])
                    
            }
            
            return cell
            
        case .more:
            return UITableViewCell()
            
        }
        
    }
    
}
