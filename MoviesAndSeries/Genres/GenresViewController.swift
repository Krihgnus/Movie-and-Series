import Foundation
import UIKit

class GenresViewController: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    
    //ATUALIZAR COM BANCO DE DADOS
        //CATEGORIES: [FILMES] - ESTE ARRAY SERA RESULTADO DE UMA BUSCA E POSSUIRA UM FILME DE CADA CATEGORIA PARA SER SETADO NESTA VIEW
    //ATUALIZAR COM BANCO DE DADOS
    
    //DELETAR COM BANCO DE DADOS
    let categories: [String] = ["Action", "Romance", "Animation", "Adventure", "Drama"]
    //DELETAR COM BANCO DE DADOS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.rowHeight = 170
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
}

extension GenresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count //CATEGORIES DESTE ARQUIVO ATUALIZADO . COUNT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            print("Erro - Retornando célula não configurada")
            return UITableViewCell()
        }
        cell.configure(categories[indexPath.row]) //ENVIIAR UM FILME
        return cell
    }
    
}

extension GenresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //PREENCHER DE ACORDO
        //FAZER APARECER UMA VIEW COM APENAS OS FILMES DAQUELA CATEGORIA
        print("Categoria \(categories[indexPath.row]) selecionada!")
    }
}
