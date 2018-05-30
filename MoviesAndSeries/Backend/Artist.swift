import Foundation
import UIKit

struct Artist {
    var identifier: Int
    var nome: String
    var profissao: String
    var dataNascimento: [String: Int]
    var localNascimento: [String: String]
    var filmesId: [Int]
    var seriesId: [Int]
    var imagemCapa: URL
    var imagemCollection: URL
    var descricao: String
    var albumSecundario: PhotoAlbum
    var outrosAlbuns: [PhotoAlbum]
    
    fileprivate init(whithArtist mock: ArtistMock) {
        self.identifier = mock.indentifier
        self.nome = mock.nome
        self.profissao = mock.profissao
        self.dataNascimento = mock.dataNascimento
        self.localNascimento = mock.localNascimento
        self.filmesId = mock.filmesId
        self.seriesId = mock.seriesId
        self.imagemCapa = mock.imagemCapa
        self.imagemCollection = mock.imagemCollection
        self.descricao = mock.descricao
        self.albumSecundario = mock.albumSecundario
        self.outrosAlbuns = mock.outrosAlbuns
    }
}

private class ArtistMock {
    var indentifier: Int
    var nome: String
    var profissao: String
    var dataNascimento: [String: Int]
    var localNascimento: [String: String]
    var filmesId: [Int]
    var seriesId: [Int]
    var imagemCapa: URL
    var imagemCollection: URL
    var descricao: String
    var albumSecundario: PhotoAlbum
    var outrosAlbuns: [PhotoAlbum]
    
    init(identifier: Int,
         nome: String,
         profissao: String,
         dataNascimento: [String: Int],
         localNascimento: [String: String],
         filmesId: [Int],
         seriesId: [Int],
         imagemCapa: URL,
         imagemCollection: URL,
         descricao: String,
         albumSecundario: PhotoAlbum,
         outrosAlbuns: [PhotoAlbum]) {
        self.indentifier = identifier
        self.nome = nome
        self.profissao = profissao
        self.dataNascimento = dataNascimento
        self.localNascimento = localNascimento
        self.filmesId = filmesId
        self.seriesId = seriesId
        self.imagemCapa = imagemCapa
        self.imagemCollection = imagemCollection
        self.descricao = descricao
        self.albumSecundario = albumSecundario
        self.outrosAlbuns = outrosAlbuns
    }
}

private var allArtistsMock: [ArtistMock] = [
    ArtistMock(identifier: 1,
               nome: "Chris Scott",
               profissao: "Actor",
               dataNascimento: ["Dia": 6, "Mes": 7, "Ano": 1992],
               localNascimento: ["Cidade": "Los Angeles", "Estado": "California", "Pais": "USA"],
               filmesId: [1],
               seriesId: [2],
               imagemCapa: URL(string: "https://cdn.pixabay.com/photo/2014/04/02/17/04/man-307821_960_720.png")!,
               imagemCollection: URL(string: "https://st.depositphotos.com/2704315/3185/v/950/depositphotos_31854223-stock-illustration-vector-user-profile-avatar-man.jpg")!,
               descricao: "Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott",
               albumSecundario: allSecondaryAlbums[0],
               outrosAlbuns: [allAlbums[0]]
    ),
    ArtistMock(identifier: 2,
               nome: "Maria Silva",
               profissao: "Actress",
               dataNascimento: ["Dia": 4, "Mes": 10, "Ano": 1996],
               localNascimento: ["Estado": "Rio Grande do Sul", "Pais": "BR"],
               filmesId: [2],
               seriesId: [1, 2],
               imagemCapa: URL(string: "https://cdn.pixabay.com/photo/2014/04/02/17/04/woman-307822_960_720.png")!,
               imagemCollection: URL(string: "https://thumbs.dreamstime.com/b/%C3%ADcone-executivo-novo-do-perfil-da-mulher-81933600.jpg")!,
               descricao: "Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva",
               albumSecundario: allSecondaryAlbums[1],
               outrosAlbuns: [allAlbums[1]]
    )
]

var allArtists: [Artist] {
    return [Artist(whithArtist: allArtistsMock[0]), Artist(whithArtist: allArtistsMock[1])]
}

class ArtistsServer {
    static func takeAllArtists(onCompletion completionHandler: @escaping ([Artist]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let success = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true

            if success {
                 completionHandler(allArtists)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    static func takeArtist(byId: Int, onCompletion completionHandler: @escaping (Artist?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let success = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if  success {
                for artist in allArtists {
                    if artist.identifier == byId {
                        completionHandler(artist)
                        return
                    }
                }
            } else {
                completionHandler(nil)
            }
        }
    }
}
