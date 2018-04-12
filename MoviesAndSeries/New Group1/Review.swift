import Foundation
import UIKit

enum FilmeSerie {
    case serie
    case filme
}

struct Review {
    let nomeUsuario: String
    let fotoUsuario: URL
    let dataReview: [String: Int] // "Dia": 00, "Mes": 00, "Ano": 0000
    let estrelas: Int
    let nomeFilmeSerie: String //Resgistrada quando o usuario seleciona a celula, confirmada quando o usuario envia a review
    let tipoFilmeSerie: FilmeSerie
    let filmeSerieIdentifier: Int
    let comentario: String
    let likes: Int
}

//Banco de dados de reviews ficticias

//Foto Krihgnus
let review1: Review = Review(nomeUsuario: "Krihgnus",
                             fotoUsuario: URL(string: "https://avatars0.githubusercontent.com/u/33634251?s=460&v=4")!,
                             dataReview: ["Dia": 4, "Mes": 5, "Ano": 2017],
                             estrelas: 5,
                             nomeFilmeSerie: "SOTC Season 1",
                             tipoFilmeSerie: .serie,
                             filmeSerieIdentifier: 1,
                             comentario: "A SERIE SOTC SEASON 1 ... Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus",
                             likes: 10
)

//Foto User Masculino
let review2: Review = Review(nomeUsuario: "User133",
                             fotoUsuario: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsAUelg7yg0mepGMf-N93hh6E9XrLnKwsKa4YEQ6swhDknk4F9eQ")!,
                             dataReview: ["Dia": 3, "Mes": 3, "Ano": 2016],
                             estrelas: 3,
                             nomeFilmeSerie: "Park",
                             tipoFilmeSerie: .filme,
                             filmeSerieIdentifier: 2,
                             comentario: "O FILME PARK ... Comment User133, Comment User133, Comment User133, Comment User133, Comment User133, Comment User133, Comment User133",
                             likes: 8
)

//Foto User Feminino
let review3: Review = Review(nomeUsuario: "Katia",
                             fotoUsuario: URL(string: "https://www.shareicon.net/data/2016/09/01/822739_user_512x512.png")!,
                             dataReview: ["Dia": 2, "Mes": 8, "Ano": 2017],
                             estrelas: 2,
                             nomeFilmeSerie: "SOTC Season 2",
                             tipoFilmeSerie: .serie,
                             filmeSerieIdentifier: 2,
                             comentario: "A SERIE SOTC SEASON 2 ... Comment Katia, Comment Katia, Comment Katia, Comment Katia, Comment Katia, Comment Katia, Comment Katia",
                             likes: 3
)

//Foto Anonimo
let review4: Review = Review(nomeUsuario: "Anonymous",
                             fotoUsuario: URL(string: "http://downloadicons.net/sites/default/files/anonymous-user-icon-38989.png")!,
                             dataReview: ["Dia": 1, "Mes": 12, "Ano": 2016],
                             estrelas: 1,
                             nomeFilmeSerie: "The other",
                             tipoFilmeSerie: .filme,
                             filmeSerieIdentifier: 1,
                             comentario: "O FILME THE OTHER ... 01001010101000010101101101101100001010101",
                             likes: 0
)

//Todas Reviews
let allReviews: [Review] = [review1, review2, review3, review4]

//Class ficticia que representa o servidor que puxa os dados das reviews de um banco de dados atraves de requests
class ReviewsServer {
    static func takeReviewsToFilm(by filmId: Int, filmType: FilmeSerie, onCompletion completionHandler: @escaping ([Review]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            var reviewsToFilmSerie: [Review] = []
            if arc4random_uniform(2) == 0 {
                for review in allReviews {
                    if review.tipoFilmeSerie == filmType && review.filmeSerieIdentifier == filmId {
                        reviewsToFilmSerie.append(review)
                    }
                }
                completionHandler(reviewsToFilmSerie)
            } else {
                completionHandler(nil)
            }
        }
    }
}

