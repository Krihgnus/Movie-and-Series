//
//  TestTableView.swift
//  Movies & Series
//
//  Created by Nodo Digital on 3/29/18.
//  Copyright © 2018 Nodo Digital. All rights reserved.
//

import UIKit

class TestTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch typeTableView {
        case .summary:
            return 1
        case .movies:
            return 3 //MOVIESQFEZ.COUNT
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
        
        //        switch typeTableView {
        //        case .summary:
        //            guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell") as? CellSummaryType else {
        //                print("Erro - Retornando célula não configurada")
        //                return UITableViewCell()
        //            }
        //            cell.configure(artista) //CELL.CONFIGURE(OBJ ARTISTA)
        //            cell.backgroundColor = .lightGray
        //            return cell
        //
        //        case .movies:
        //            guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? CellMoviesType else {
        //                print("Erro - Retornando célula não configurada")
        //                return UITableViewCell()
        //            }
        //            cell.configure(filme) //CELL.CONFIGURE(OBJ FILME)
        //            cell.backgroundColor = .lightGray
        //            return cell
        //        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if typeTableView == .movies {
            //IR PARA A TELA DE DETALHES DO DETERMINADO FILME
            print("Voce selecionou o filme numero \(indexPath.row)")
        }
    }

}


