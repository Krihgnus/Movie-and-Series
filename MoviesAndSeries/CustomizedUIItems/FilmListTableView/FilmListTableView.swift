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
        
        delegate = self
        dataSource = self
        
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
            return artistToTableView.filmesId.count + artistToTableView.seriesId.count
            
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
            
            if filmsByArtist.count == 0  || seriesByArtist.count == 0 {
                
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

extension FilmList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //PROVISORIO - APRIMORAR
        if tbvType == .movies {
            
            //IR PARA A TELA DE DETALHES DO DETERMINADO FILME
            print("Filme número \(indexPath.row) selecionado")
            
        }
        
    }
    
}

