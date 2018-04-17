import Foundation
import UIKit

enum TableViewType {
    case summary
    case movies
    case more
}

var typeTableView: TableViewType = .summary

class FilmList: UITableView {
    static let sharedTableView = FilmList()
    
//ATUALIZAR COM O BANCO DE DADOS
    //STATIC VAR ARTISTA = ARTISTA! ESTE ARTISTA JA VAI CONTER O ARRAY FILMES QUE FEZ COMO UMA DE SUAS PROPRIEDADES
    //A PARTIR DESTES DADOS MONTAR AS CELULAS CORRESPONDENTES
//ATUALIZAR COM O BANCO DE DADOS
    
    //DELETAR COM BANCO DE DADOS
    let artista: [String] = ["TEST NAME", "DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST, DESCRIPTION TEST"]
    let filme: [String: String] = ["name": "TESTE", "categories": "Action | Romance"]
    
    //DELETAR COM BANCO DE DADOS
}

extension FilmList: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch typeTableView {
        case .summary:
            return 1
        case .movies:
            return 3 //MOVIESQFEZ.COUNT
        case .more:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch typeTableView {
        case .summary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell") as? CellSummaryType else {
                print("Erro - Retornando célula não configurada")
                return UITableViewCell()
            }
            cell.configure(artista) //CELL.CONFIGURE(OBJ ARTISTA)
            return cell
        case .movies:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? CellMoviesType else {
                print("Erro - Retornando célula não configurada")
                return UITableViewCell()
            }
            cell.configure(filme) //CELL.CONFIGURE(OBJ FILME)
            return cell
        case .more:
            return UITableViewCell()
        }
    }
}

extension FilmList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //PROVISORIO - APRIMORAR
        if typeTableView == .movies {
            //IR PARA A TELA DE DETALHES DO DETERMINADO FILME
            print("Filme número \(indexPath.row) selecionado")
        }
    }
}
