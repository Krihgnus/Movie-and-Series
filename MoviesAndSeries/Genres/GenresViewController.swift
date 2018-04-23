import Foundation
import UIKit

class GenresViewController: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var tableViewActivityIndicator: UIActivityIndicatorView!
    
    var arrCategories: [String] = []
    var arrImages: [URL] = []
    var filmsRequestSuccess: Bool = false
    var seriesRequestSuccess: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        categoryTableView.rowHeight = 170
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        tableViewActivityIndicator.startAnimating()
        
        if filmsRequestSuccess == true && seriesRequestSuccess == true {
            
            tableViewActivityIndicator.stopAnimating()
            
        }
        
        var existingCategories: Int = self.arrCategories.count
        
        if filmsRequestSuccess == false {
            
            //Request Filmes
            FilmsSever.takeAllFilms { allFilms in
                if let films = allFilms {
                    
                    for film in films {
                        
                        for categorie in film.categorias {
                            
                            for categoria in self.arrCategories {
                                
                                if categoria != categorie {
                                    
                                    existingCategories -= 1
                                    
                                }
                                
                            }
                            
                            if existingCategories == 0 {
                                
                                print("CATEGORIA: \(categorie) ADICIONADO")
                                self.arrCategories.append(categorie)
                                self.arrImages.append(film.capa)
                                
                            }
                            
                            existingCategories = self.arrCategories.count
                            
                        }
                        
                    }
                    
                    self.filmsRequestSuccess = true
                    
                    if self.seriesRequestSuccess == true {
                        
                        self.categoryTableView.reloadData()
                        self.categoryTableView.isHidden = false
                        self.tableViewActivityIndicator.stopAnimating()
                        
                    }
                    
                } else {
                    
                    self.presentNetworkErrorAlert()
                    self.tableViewActivityIndicator.stopAnimating()
                    print("Erro - Array de filmes retornou nil")
                    
                }
                
            }
            
        }
        
        if seriesRequestSuccess == false {
            
            //Request Serie
            SeriesServer.takeAllSeries { allSeries in
                if let series = allSeries {
                    
                    for serie in series {
                        
                        for categorie in serie.categorias {
                            
                            for categoria in self.arrCategories {
                                
                                if categoria != categorie {
                                    
                                    existingCategories -= 1
                                    
                                }
                                
                            }
                            
                            if existingCategories == 0 {
                                
                                self.arrCategories.append(categorie)
                                self.arrImages.append(serie.capa)
                                
                            }
                            
                            existingCategories = self.arrCategories.count
                            
                        }
                        
                    }
                    
                    self.seriesRequestSuccess = true
                    
                    if self.filmsRequestSuccess == true {
                        
                        self.categoryTableView.reloadData()
                        self.categoryTableView.isHidden = false
                        self.tableViewActivityIndicator.stopAnimating()
                        
                    }
                    
                } else {
                    
                    self.presentNetworkErrorAlert()
                    self.tableViewActivityIndicator.stopAnimating()
                    print("Erro - Array de Séries retornou nil")
                    
                }
                
            }
            
        }
        
    }
    
}

extension GenresViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCategories.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            
            print("Erro - Retornando célula não configurada")
            return UITableViewCell()
            
        }
        
        cell.configure(name: arrCategories[indexPath.row], image: arrImages[indexPath.row])
        return cell
        
    }
    
}

extension GenresViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let listOfGenreReference = storyboard?.instantiateViewController(withIdentifier: "listOfGenreVC") as? ListOfGenre {
            
            navigationController?.pushViewController(listOfGenreReference, animated: true)
            print("Categoria \(arrCategories[indexPath.row]) selecionada!")
            //PASSAR DADOS
            
        }
        
    }
    
}
