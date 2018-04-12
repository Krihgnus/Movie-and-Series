import Foundation
import UIKit

struct Artist {
    let identifier: Int
    let nome: String
    let profissao: String
    let dataNascimento: [String: Int] // "Dia": 00, "Mes": 00, "Ano": 0000
    let localNascimento: [String: String] //"Cidade": "AAAA", "Estado": "BBBBB", "Pais": "CCCC"
    let filmesId: [Int]
    let seriesId: [Int]
    let imagemCapa: URL
    let imagemCollection: URL
    let descricao: String
    let albumSecundario: PhotoAlbum
    let outrosAlbuns: [PhotoAlbum]
}

//Banco de dados de artistas ficticios

//Homem
let artist1: Artist = Artist(identifier: 1,
                             nome: "Joao Silva",
                             profissao: "Actor",
                             dataNascimento: ["Dia": 6, "Mes": 7, "Ano": 1992],
                             localNascimento: ["Cidade": "Sao Paulo", "Estado": "Sao Paulo", "Pais": "Brazil"],
                             filmesId: [1],
                             seriesId: [2],
                             imagemCapa: URL(string: "https://cdn.pixabay.com/photo/2014/04/02/17/04/man-307821_960_720.png")!,
                             imagemCollection: URL(string: "https://st.depositphotos.com/2704315/3185/v/950/depositphotos_31854223-stock-illustration-vector-user-profile-avatar-man.jpg")!,
                             descricao: "Description Joao Silva, Description Joao Silva, Description Joao Silva, Description Joao Silva, Description Joao Silva, Description Joao Silva",
                             albumSecundario: secondaryTestAlbum1,
                             outrosAlbuns: [otherAlbum1])

//Mulher
let artist2: Artist = Artist(identifier: 2,
                             nome: "Maria Silva",
                             profissao: "Actress",
                             dataNascimento: ["Dia": 4, "Mes": 10, "Ano": 1996],
                             localNascimento: ["Cidade": "Porto Alegre", "Estado": "Rio Grande do Sul", "Pais": "Brazil"],
                             filmesId: [2],
                             seriesId: [1, 2],
                             imagemCapa: URL(string: "https://cdn.pixabay.com/photo/2014/04/02/17/04/woman-307822_960_720.png")!,
                             imagemCollection: URL(string: "https://thumbs.dreamstime.com/b/%C3%ADcone-executivo-novo-do-perfil-da-mulher-81933600.jpg")!,
                             descricao: "Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva",
                             albumSecundario: secondaryTestAlbum2,
                             outrosAlbuns: [otherAlbum2])

//Todos Artistas
let allArtists: [Artist] = [artist1, artist2]

//Class ficticia que representa o servidor que puxa os dados dos atores de um banco de dados atraves de requests
class ArtistsServer {
    static func takeAllArtists(onCompletion completionHandler: @escaping ([Artist]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            if arc4random_uniform(2) == 0 {
                 completionHandler(allArtists)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    static func takeArtist(byId: Int, onCompletion completionHandler: @escaping (Artist?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            if arc4random_uniform(2) == 0 {
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
