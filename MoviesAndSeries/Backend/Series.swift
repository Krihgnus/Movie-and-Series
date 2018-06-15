import Foundation
import UIKit

struct Serie {
    var identifier: Int
    var nome: String
    var trailer: URL
    var categorias: [String]
    var linguagemOriginal: String
    var dataLancamento: [String: Int]
    var siglaPaisLancamento: String
    var descricao: String
    var capa: URL
    var atores: [Artist]
    var avaliacoes: [Review]
    var nEpisodios: Int
    var duracaoEpisodio: Int
    
    fileprivate init(withSerie mock: SerieMock) {
        self.identifier = mock.identifier
        self.nome = mock.nome
        self.trailer = mock.trailer
        self.categorias = mock.categorias
        self.linguagemOriginal = mock.linguagemOriginal
        self.dataLancamento = mock.dataLancamento
        self.siglaPaisLancamento = mock.siglaPaisLancamento
        self.descricao = mock.descricao
        self.capa = mock.capa
        self.atores = mock.atores
        self.avaliacoes = mock.avaliacoes
        self.nEpisodios = mock.nEpisodios
        self.duracaoEpisodio = mock.duracaoEpisodio
    }
}

private class SerieMock {
    var identifier: Int
    var nome: String
    var trailer: URL
    var categorias: [String]
    var linguagemOriginal: String
    var dataLancamento: [String: Int]
    var siglaPaisLancamento: String
    var descricao: String
    var capa: URL
    var atores: [Artist]
    var avaliacoes: [Review] {
        var reviews: [Review] = []
        for review in allReviews {
            if review.filmeSerieIdentifier == identifier && review.tipoFilmeSerie == .serie {
                reviews.append(review)
            }
        }
        return reviews
    }
    var nEpisodios: Int
    var duracaoEpisodio: Int
    
    init(identifier: Int,
         nome: String,
         trailer: URL,
         categorias: [String],
         linguagemOriginal: String,
         dataLancamento: [String: Int],
         siglaPaisLancamento: String,
         descricao: String,
         capa: URL,
         atores: [Artist],
         nEpisodios: Int,
         duracaoEpisodio: Int) {
        self.identifier = identifier
        self.nome = nome
        self.trailer = trailer
        self.categorias = categorias
        self.linguagemOriginal = linguagemOriginal
        self.dataLancamento = dataLancamento
        self.siglaPaisLancamento = siglaPaisLancamento
        self.descricao = descricao
        self.capa = capa
        self.atores = atores
        self.nEpisodios = nEpisodios
        self.duracaoEpisodio = duracaoEpisodio
    }
}

private var allSeriesMock: [SerieMock] = [
    SerieMock(identifier: 1,
              nome: "SOTC Season 1",
              trailer: URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!,
              categorias: ["Action", "Romance", "Fantasy"],
              linguagemOriginal: "English",
              dataLancamento: ["Dia": 16, "Mes": 6, "Ano": 2018],
              siglaPaisLancamento: "USA",
              descricao: "Description SOTC Season 1, Description SOTC Season 1, Description SOTC Season 1, Description SOTC Season 1, Description SOTC Season 1",
              capa: URL(string: "https://static1.squarespace.com/static/54bfc46be4b0a0e8a51ebbf6/t/59ee3a42ec4eb7210abbcba7/1506956074525/tourback.jpg?format=2500w")!,
              atores: [allArtists[1]],
              nEpisodios: 14,
              duracaoEpisodio: 38
    ),
    SerieMock(identifier: 2,
              nome: "SOTC Season 2",
              trailer: URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!,
              categorias: ["Action", "Romance", "Fantasy", "Comedy"],
              linguagemOriginal: "English",
              dataLancamento: ["Dia": 11, "Mes": 7, "Ano": 2018],
              siglaPaisLancamento: "USA",
              descricao: "Description SOTC Season 2, Description SOTC Season 2, Description SOTC Season 2, Description SOTC Season 2, Description SOTC Season 2",
              capa: URL(string: "https://i.pinimg.com/736x/f5/56/bf/f556bfd4d04657f967547934d1149a83--turquoise-iphone-wallpaper-iphone-wallpaper-pattern-black.jpg")!,
              atores: [allArtists[0], allArtists[1]],
              nEpisodios: 5,
              duracaoEpisodio: 42
    )
]

var allSeries: [Serie] {
    return [Serie(withSerie: allSeriesMock[0]), Serie(withSerie: allSeriesMock[1])]
}

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
    
    static func takeSeries(by ids: [Int], onCompletion completionHandler: @escaping ([Serie]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            var series: [Serie] = []
        
            if sucesso {
                for serie in allSeries {
                    for id in ids {
                        if serie.identifier == id {
                            series.append(serie)
                        }
                    }
                }
                completionHandler(series)
            } else {
            completionHandler(nil)
            }
        }
    }
}
