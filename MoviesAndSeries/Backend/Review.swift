import Foundation
import UIKit

enum FilmeSerie {
    case serie
    case filme
}

struct Review {
    var identifier: Int
    var nomeUsuario: String
    var fotoUsuario: URL
    var dataReview: [String: Int]
    var estrelas: Int
    var tipoFilmeSerie: FilmeSerie
    var filmeSerieIdentifier: Int
    var comentario: String
    var likes: Int
    var userLike: Bool
    
    fileprivate init(withReview mock: ReviewMock) {
        identifier = mock.identifier
        nomeUsuario = mock.nomeUsuario
        fotoUsuario = mock.fotoUsuario
        dataReview = mock.dataReview
        estrelas = mock.estrelas
        tipoFilmeSerie = mock.tipoFilmeSerie
        filmeSerieIdentifier = mock.filmeSerieIdentifier
        comentario = mock.comentario
        likes = mock.likes
        userLike = mock.userLike
    }
}

private class ReviewMock {
    var identifier: Int
    var nomeUsuario: String
    var fotoUsuario: URL
    var dataReview: [String: Int]
    var estrelas: Int
    var tipoFilmeSerie: FilmeSerie
    var filmeSerieIdentifier: Int
    var comentario: String
    var likes: Int
    var userLike: Bool
    
    init(identifier: Int, nomeUsuario: String,
         fotoUsuario: URL,
        dataReview: [String: Int],
        estrelas: Int,
        tipoFilmeSerie: FilmeSerie,
        filmeSerieIdentifier: Int,
        comentario: String,
        likes: Int,
        userLike: Bool) {
            self.identifier = identifier
            self.nomeUsuario = nomeUsuario
            self.fotoUsuario = fotoUsuario
            self.dataReview = dataReview
            self.estrelas = estrelas
            self.tipoFilmeSerie = tipoFilmeSerie
            self.filmeSerieIdentifier = filmeSerieIdentifier
            self.comentario = comentario
            self.likes = likes
            self.userLike = userLike
    }
    
    func update(withReview review: Review) {
        self.identifier = review.identifier
        self.nomeUsuario = review.nomeUsuario
        self.fotoUsuario = review.fotoUsuario
        self.dataReview = review.dataReview
        self.estrelas = review.estrelas
        self.tipoFilmeSerie = review.tipoFilmeSerie
        self.filmeSerieIdentifier = review.filmeSerieIdentifier
        self.comentario = review.comentario
        self.likes = review.likes
        self.userLike = review.userLike
    }
}

private var allReviewMocks: [ReviewMock] = [
    ReviewMock(identifier: 1,
               nomeUsuario: "Krihgnus",
               fotoUsuario: URL(string: "https://avatars0.githubusercontent.com/u/33634251?s=460&v=4")!,
               dataReview: ["Dia": 4, "Mes": 5, "Ano": 2017],
               estrelas: 5,
               tipoFilmeSerie: .serie,
               filmeSerieIdentifier: 1,
               comentario: "A SERIE SOTC SEASON 1 ... Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus, Comment Krihgnus",
               likes: 10,
               userLike: false
    ),
    ReviewMock(identifier: 2,
               nomeUsuario: "User133",
               fotoUsuario: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsAUelg7yg0mepGMf-N93hh6E9XrLnKwsKa4YEQ6swhDknk4F9eQ")!,
               dataReview: ["Dia": 3, "Mes": 3, "Ano": 2016],
               estrelas: 3,
               tipoFilmeSerie: .filme,
               filmeSerieIdentifier: 2,
               comentario: "O FILME PARK ... Comment User133, Comment User133, Comment User133, Comment User133, Comment User133, Comment User133, Comment User133 Comment User133, Comment User133, Comment User133, Comment User133, Comment User133, Comment User133, Comment User133",
               likes: 8,
               userLike: false
    ),
    ReviewMock(identifier: 3,
               nomeUsuario: "Katia",
               fotoUsuario: URL(string: "https://www.shareicon.net/data/2016/09/01/822739_user_512x512.png")!,
               dataReview: ["Dia": 2, "Mes": 8, "Ano": 2017],
               estrelas: 2,
               tipoFilmeSerie: .serie,
               filmeSerieIdentifier: 2,
               comentario: "A SERIE SOTC SEASON 2 ... Comment Katia, Comment Katia, Comment Katia, Comment Katia, Comment Katia, Comment Katia, Comment Katia",
               likes: 3,
               userLike: false
    ),
    ReviewMock(identifier: 4,
               nomeUsuario: "Anonymous",
               fotoUsuario: URL(string: "http://downloadicons.net/sites/default/files/anonymous-user-icon-38989.png")!,
               dataReview: ["Dia": 1, "Mes": 12, "Ano": 2016],
               estrelas: 1,
               tipoFilmeSerie: .filme,
               filmeSerieIdentifier: 1,
               comentario: "O FILME THE OTHER ... 01001010101 0000101011011011011 00001010101 00001010101",
               likes: 0,
               userLike: false
    ),
    ReviewMock(identifier: 5, //PARA TESTE
               nomeUsuario: "Anonymous",
               fotoUsuario: URL(string: "http://downloadicons.net/sites/default/files/anonymous-user-icon-38989.png")!,
               dataReview: ["Dia": 1, "Mes": 12, "Ano": 2016],
               estrelas: 1,
               tipoFilmeSerie: .filme,
               filmeSerieIdentifier: 1,
               comentario: "O FILME THE OTHER ... 01001010101 0000101011011011011 00001010101 00001010101",
               likes: 0,
               userLike: false
    ),
    ReviewMock(identifier: 6, //PARA TESSTE
               nomeUsuario: "Anonymous",
               fotoUsuario: URL(string: "http://downloadicons.net/sites/default/files/anonymous-user-icon-38989.png")!,
               dataReview: ["Dia": 1, "Mes": 12, "Ano": 2016],
               estrelas: 1,
               tipoFilmeSerie: .filme,
               filmeSerieIdentifier: 1,
               comentario: "O FILME THE OTHER ... 01001010101 0000101011011011011 00001010101 00001010101",
               likes: 0,
               userLike: false
    ),
    ReviewMock(identifier: 7, //PARA TESTE
               nomeUsuario: "Anonymous",
               fotoUsuario: URL(string: "http://downloadicons.net/sites/default/files/anonymous-user-icon-38989.png")!,
               dataReview: ["Dia": 1, "Mes": 12, "Ano": 2016],
               estrelas: 1,
               tipoFilmeSerie: .filme,
               filmeSerieIdentifier: 1,
               comentario: "O FILME THE OTHER ... 01001010101 0000101011011011011 00001010101 00001010101",
               likes: 0,
               userLike: false
    ),
    ReviewMock(identifier: 8, //PARA TESTE
               nomeUsuario: "Anonymous",
               fotoUsuario: URL(string: "http://downloadicons.net/sites/default/files/anonymous-user-icon-38989.png")!,
               dataReview: ["Dia": 1, "Mes": 12, "Ano": 2016],
               estrelas: 1,
               tipoFilmeSerie: .filme,
               filmeSerieIdentifier: 1,
               comentario: "O FILME THE OTHER ... 01001010101 0000101011011011011 00001010101 00001010101",
               likes: 0,
               userLike: false
    ),
    ReviewMock(identifier: 9, //PARA TESTE
               nomeUsuario: "Anonymous",
               fotoUsuario: URL(string: "http://downloadicons.net/sites/default/files/anonymous-user-icon-38989.png")!,
               dataReview: ["Dia": 1, "Mes": 12, "Ano": 2016],
               estrelas: 1,
               tipoFilmeSerie: .filme,
               filmeSerieIdentifier: 1,
               comentario: "O FILME THE OTHER ... 01001010101 0000101011011011011 00001010101 00001010101",
               likes: 0,
               userLike: false
    )
]

var allReviews: [Review] {
    return allReviewMocks.map({ Review(withReview: $0) })
}

class ReviewsServer {
    static func takeReviewsToFilm(by filmId: Int, filmType: FilmeSerie, onCompletion completionHandler: @escaping ([Review]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            var reviewsToFilmSerie: [Review] = []
            
            if sucesso {
                
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

    static func updateReview(_ review: Review, onCompletion completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                guard let reviewMock = allReviewMocks.filter({ $0.identifier == review.identifier }).first else {
                    completionHandler(false)
                    return
                }
                reviewMock.update(withReview: review)
            }
            completionHandler(sucesso)
        }
    }
    
    static func addReview(_ review: Review, onCompletion completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                allReviewMocks.append(ReviewMock(identifier: review.identifier,
                                                 nomeUsuario: review.nomeUsuario,
                                                 fotoUsuario: review.fotoUsuario,
                                                 dataReview: review.dataReview,
                                                 estrelas: review.estrelas,
                                                 tipoFilmeSerie: review.tipoFilmeSerie,
                                                 filmeSerieIdentifier: review.filmeSerieIdentifier,
                                                 comentario: review.comentario,
                                                 likes: review.likes,
                                                 userLike: review.userLike)
                )
            }
            completionHandler(sucesso)
        }
    }
    
    static func countReviews(onCompletion completionHandler: @escaping (Int?) -> Void) {
        let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
        
        if sucesso {
            completionHandler(allReviews.count)
        } else {
            completionHandler(nil)
        }
    }
}
