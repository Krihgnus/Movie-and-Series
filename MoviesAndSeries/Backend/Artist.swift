import Foundation
import UIKit

struct Artist {
    var identifier: Int
    var name: String
    var work: String
    var birthDate: [String: Int]
    var hometown: [String: String]
    var moviesId: [Int]
    var seriesId: [Int]
    var coverImage: URL
    var artistCollectionImage: URL
    var description: String
    var secondaryAlbum: PhotoAlbum
    var otherAlbums: [PhotoAlbum]
    
    fileprivate init(whithArtist mock: ArtistMock) {
        self.identifier = mock.identifier
        self.name = mock.name
        self.work = mock.work
        self.birthDate = mock.birthDate
        self.hometown = mock.hometown
        self.moviesId = mock.moviesId
        self.seriesId = mock.seriesId
        self.coverImage = mock.coverImage
        self.artistCollectionImage = mock.artistCollectionImage
        self.description = mock.description
        self.secondaryAlbum = mock.secondaryAlbum
        self.otherAlbums = mock.otherAlbums
    }
}

private class ArtistMock {
    var identifier: Int
    var name: String
    var work: String
    var birthDate: [String: Int]
    var hometown: [String: String]
    var moviesId: [Int]
    var seriesId: [Int]
    var coverImage: URL
    var artistCollectionImage: URL
    var description: String
    var secondaryAlbum: PhotoAlbum
    var otherAlbums: [PhotoAlbum]
    
    init(identifier: Int,
         name: String,
         work: String,
         birthDate: [String: Int],
         hometown: [String: String],
         moviesId: [Int],
         seriesId: [Int],
         coverImage: URL,
         artistCollectionImage: URL,
         description: String,
         secondaryAlbum: PhotoAlbum,
         otherAlbums: [PhotoAlbum]) {
        self.identifier = identifier
        self.name = name
        self.work = work
        self.birthDate = birthDate
        self.hometown = hometown
        self.moviesId = moviesId
        self.seriesId = seriesId
        self.coverImage = coverImage
        self.artistCollectionImage = artistCollectionImage
        self.description = description
        self.secondaryAlbum = secondaryAlbum
        self.otherAlbums = otherAlbums
    }
}

private var allArtistsMock: [ArtistMock] = [
    ArtistMock(identifier: 1,
               name: "Chris Scott",
               work: "Actor",
               birthDate: ["Dia": 6, "Mes": 7, "Ano": 1992],
               hometown: ["Cidade": "Los Angeles", "Estado": "California", "Pais": "USA"],
               moviesId: [1],
               seriesId: [2],
               coverImage: URL(string: "https://cdn.pixabay.com/photo/2014/04/02/17/04/man-307821_960_720.png")!,
               artistCollectionImage: URL(string: "https://st.depositphotos.com/2704315/3185/v/950/depositphotos_31854223-stock-illustration-vector-user-profile-avatar-man.jpg")!,
               description: "Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott, Description Chris Scott",
               secondaryAlbum: allSecondaryAlbums[0],
               otherAlbums: [allAlbums[0]]
    ),
    ArtistMock(identifier: 2,
               name: "Maria Silva",
               work: "Actress",
               birthDate: ["Dia": 4, "Mes": 10, "Ano": 1996],
               hometown: ["Estado": "Rio Grande do Sul", "Pais": "BR"],
               moviesId: [2],
               seriesId: [1, 2],
               coverImage: URL(string: "https://cdn.pixabay.com/photo/2014/04/02/17/04/woman-307822_960_720.png")!,
               artistCollectionImage: URL(string: "https://thumbs.dreamstime.com/b/%C3%ADcone-executivo-novo-do-perfil-da-mulher-81933600.jpg")!,
               description: "Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva, Description Maria Silva",
               secondaryAlbum: allSecondaryAlbums[1],
               otherAlbums: [allAlbums[1], allAlbums[2]]
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
