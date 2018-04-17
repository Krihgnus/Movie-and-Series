import Foundation
import UIKit

struct Serie {
    let identifier: Int
    let nome: String
    let trailer: URL
    let categorias: [String]
    let mediaEstrelas: Int
    let totalAvaliacoes: Int
    let linguagensDisponiveis: [String]
    let dataLancamento: [String: Int] // "Dia": 00, "Mes": 00, "Ano": 0000
    let siglaPaisLancamento: String //BR
    let descricao: String
    let capa: URL
    let atores: [Artist]
    let avaliacoes: [Review]
    let nEpisodios: Int
    let duracaoEpisodio: Int
}

//Banco de dados de series ficticias

//Capa Vermelha
let serie1: Serie = Serie(identifier: 1,
                          nome: "SOTC Season 1",
                          trailer: URL(string: "https://www.youtube.com/watch?v=C0DPdy98e4c")!,
                          categorias: ["Action", "Romance", "Fantasy"],
                          mediaEstrelas: 5,
                          totalAvaliacoes: 23,
                          linguagensDisponiveis: ["English", "Portuguese", "Spanish"],
                          dataLancamento: ["Dia": 1, "Mes": 4, "Ano": 2009],
                          siglaPaisLancamento: "USA",
                          descricao: "Description SOTC Season 1, Description SOTC Season 1, Description SOTC Season 1, Description SOTC Season 1, Description SOTC Season 1",
                          capa: URL(string: "https://static1.squarespace.com/static/54bfc46be4b0a0e8a51ebbf6/t/59ee3a42ec4eb7210abbcba7/1506956074525/tourback.jpg?format=2500w")!,
                          atores: [artist2],
                          avaliacoes: [review1],
                          nEpisodios: 14,
                          duracaoEpisodio: 38)

//Capa Trevos
let serie2: Serie = Serie(identifier: 2,
                          nome: "SOTC Season 2",
                          trailer: URL(string: "https://www.youtube.com/watch?v=C0DPdy98e4c")!,
                          categorias: ["Action", "Romance", "Fantasy"],
                          mediaEstrelas: 4,
                          totalAvaliacoes: 14,
                          linguagensDisponiveis: ["English"],
                          dataLancamento: ["Dia": 4, "Mes": 4, "Ano": 2018],
                          siglaPaisLancamento: "USA",
                          descricao: "Description SOTC Season 2, Description SOTC Season 2, Description SOTC Season 2, Description SOTC Season 2, Description SOTC Season 2",
                          capa: URL(string: "http://juliannehough.com/wp-content/uploads/2016/02/jules-green-eyes.jpg")!,
                          atores: [artist1, artist2],
                          avaliacoes: [review2],
                          nEpisodios: 5,
                          duracaoEpisodio: 42)

//Todas Series
let allSeries: [Serie] = [serie1, serie2]

//Class ficticia que representa o servidor que puxa os dados dos filmes de um banco de dados atraves de requests
class SeriesServer {
    static func takeAllSeries(onCompletion completionHandler: @escaping ([Serie]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                
                completionHandler(allSeries)
                
            } else {
                
                completionHandler(nil)
                
            }
            
        }
        
    }
    
    static func takeSerie(by id: Int, onCompletion completionHandler: @escaping (Serie?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                
                for serie in allSeries {
                    
                    if serie.identifier == id {
                        
                        completionHandler(serie)
                        return
                        
                    }
                    
                }
                
            } else {
                
                completionHandler(nil)
                
            }
            
        }
        
    }
    
}
