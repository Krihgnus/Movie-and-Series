import Foundation
import UIKit

var shouldRandomizeResults: Bool { return false }

struct Film {
    var identifier: Int
    var nome: String
    var trailer: URL
    var categorias: [String]
    var linguagemOriginal: String
    var duracao: String
    var dataLancamento: [String: Int]
    var siglaPaisLancamento: String
    var descricao: String
    var capa: URL
    var atores: [Artist]
    var avaliacoes: [Review]
    
    fileprivate init(withFilm mock: FilmMock) {
        self.identifier = mock.identifier
        self.nome = mock.nome
        self.trailer = mock.trailer
        self.categorias = mock.categorias
        self.linguagemOriginal = mock.linguagemOriginal
        self.duracao = mock.duracao
        self.dataLancamento = mock.dataLancamento
        self.siglaPaisLancamento = mock.siglaPaisLancamento
        self.descricao = mock.descricao
        self.capa = mock.capa
        self.atores = mock.atores
        self.avaliacoes = mock.avaliacoes
    }
}

private class FilmMock {
    var identifier: Int
    var nome: String
    var trailer: URL
    var categorias: [String]
    var linguagemOriginal: String
    var duracao: String
    var dataLancamento: [String: Int]
    var siglaPaisLancamento: String
    var descricao: String
    var capa: URL
    var atores: [Artist]
    var avaliacoes: [Review] {
        var reviews: [Review] = []
        for review in allReviews {
            if review.filmeSerieIdentifier == identifier && review.tipoFilmeSerie == .filme {
                reviews.append(review)
            }
        }
        return reviews
    }
    
    init(identifier: Int,
         nome: String,
         trailer: URL,
         categorias: [String],
         linguagemOriginal: String,
         duracao: String,
         dataLancamento: [String: Int],
         siglaPaisLancamento: String,
         descricao: String,
         capa: URL,
         atores: [Artist]) {
        self.identifier = identifier
        self.nome = nome
        self.trailer = trailer
        self.categorias = categorias
        self.linguagemOriginal = linguagemOriginal
        self.duracao = duracao
        self.dataLancamento = dataLancamento
        self.siglaPaisLancamento = siglaPaisLancamento
        self.descricao = descricao
        self.capa = capa
        self.atores = atores
    }
}

private var allFilmsMock: [FilmMock] = [
    FilmMock(identifier: 1,
         nome: "The other",
         trailer: URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!,
         categorias: ["Suspense", "Horror"],
         linguagemOriginal: "English",
         duracao: "2h 56m",
         dataLancamento: ["Dia": 5, "Mes": 3, "Ano": 2016],
         siglaPaisLancamento: "USA",
         descricao: "Description The other, Description The other, Description The other, Description The other, Description The other, Description The other, Description The other",
         capa: URL(string: "https://cdn-images-1.medium.com/max/2000/1*gd1Ol3uoy7v-q1MqPF-3Xw.jpeg")!,
         atores: [allArtists[0]]
    ),
    FilmMock(identifier: 2,
         nome: "Park",
         trailer: URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!,
         categorias: ["Animation"],
         linguagemOriginal: "Portuguese",
         duracao: "1h 44m",
         dataLancamento: ["Dia": 22, "Mes": 6, "Ano": 2013],
         siglaPaisLancamento: "BR",
         descricao: "Description Park, Description Park, Description Park, Description Park, Description Park, Description Park, Description Park",
         capa: URL(string: "https://cdn.alojasegura.com.br/static/567/sku/tricoline-100-alg-lisa-amarelo-ouro-tricoline-100-alg-lisa-1473971893647.jpg")!,
         atores: [allArtists[1]]
    )
]

var allFilms: [Film] {
    return [Film(withFilm: allFilmsMock[0]), Film(withFilm: allFilmsMock[1])]
}

class FilmsSever {
    static func takeAllFilms(ids: [Int]? = nil, onCompletion completionHandler: @escaping ([Film]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if  sucesso {
                var films: [Film] = []
                if let ids = ids {
                    films = allFilms.filter({ ids.contains($0.identifier) })
                } else {
                    films = allFilms
                }
                completionHandler(films)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    static func takeFilm(by id: Int, onCompletion completionHandler: @escaping (Film?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if let film = allFilms.filter({ return $0.identifier == id }).first, sucesso {
                completionHandler(film)
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
                for filme in allFilms {
                    for id in ids {
                        if filme.identifier == id {
                            filmes.append(filme)
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
