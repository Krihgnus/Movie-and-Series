import Foundation
import UIKit

var shouldRandomizeResults: Bool { return false }

struct Film {
    let identifier: Int
    let nome: String
    let trailer: URL
    let categorias: [String]
    let mediaEstrelas: Int
    let totalAvaliacoes: Int
    let linguagensDisponiveis: [String]
    let duracao: String 
    let dataLancamento: [String: Int]
    let siglaPaisLancamento: String
    let descricao: String
    let capa: URL
    let atores: [Artist]
    let avaliacoes: [Review]
}

//Banco de dados de filmes ficticios

//Capa Cinza
let film1: Film = Film(identifier: 1,
                       nome: "The other",
                       trailer: URL(string: "https://www.youtube.com/watch?v=C0DPdy98e4c")!,
                       categorias: ["Suspense", "Horror"],
                       mediaEstrelas: 4,
                       totalAvaliacoes: 7,
                       linguagensDisponiveis: ["English, Portuguese"],
                       duracao: "2h 56m",
                       dataLancamento: ["Dia": 5, "Mes": 3, "Ano": 2016],
                       siglaPaisLancamento: "USA",
                       descricao: "Description The other, Description The other, Description The other, Description The other, Description The other, Description The other, Description The other",
                       capa: URL(string: "https://cdn-images-1.medium.com/max/2000/1*gd1Ol3uoy7v-q1MqPF-3Xw.jpeg")!,
                       atores: [artist1],
                       avaliacoes: [review1])

//Capa Amarela
let film2: Film = Film(identifier: 2,
                       nome: "Park",
                       trailer: URL(string: "https://www.youtube.com/watch?v=C0DPdy98e4c")!,
                       categorias: ["Animation"],
                       mediaEstrelas: 2,
                       totalAvaliacoes: 15,
                       linguagensDisponiveis: ["Spanish", "Portuguese"],
                       duracao: "1h 44m",
                       dataLancamento: ["Dia": 22, "Mes": 6, "Ano": 2013],
                       siglaPaisLancamento: "BR",
                       descricao: "Description Park, Description Park, Description Park, Description Park, Description Park, Description Park, Description Park",
                       capa: URL(string: "https://cdn.alojasegura.com.br/static/567/sku/tricoline-100-alg-lisa-amarelo-ouro-tricoline-100-alg-lisa-1473971893647.jpg")!,
                       atores: [artist2],
                       avaliacoes: [review2])

//Todos Filmes
let allFilms: [Film] = [film1, film2]

//Class ficticia que representa o servidor que puxa os dados dos filmes de um banco de dados atraves de requests
class FilmsSever {
    
    static func takeAllFilms(onCompletion completionHandler: @escaping ([Film]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if  sucesso {
                
                completionHandler(allFilms)
                
            } else {
                
                completionHandler(nil)
                
            }
            
        }
        
    }
    
    static func takeFilm(by id: Int, onCompletion completionHandler: @escaping (Film?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                
                for film in allFilms {
                    
                    if film.identifier == id {
                        
                        completionHandler(film)
                        return
                        
                    }
                    
                }
                
            } else {
                
                completionHandler(nil)
            }
            
        }
        
    }
    
    static func takeFilms(by ids: [Int], onCompletion completionHandler: @escaping ([Film]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            var filmes: [Film] = []
        
            if sucesso {
            
                for film in allFilms {
                
                    for id in ids {
                    
                        if film.identifier == id {
                        
                            filmes.append(film)
                        
                        }
                    
                    }
                
                }
                
                completionHandler(filmes)
            
            } else {
            
            completionHandler(nil)
            
            }
        
        }
    
    }
    
}
