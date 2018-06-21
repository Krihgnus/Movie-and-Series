import Foundation
import UIKit
    
struct PhotoAlbum {
    var photographer: String
    var artistName: String
    var artistId: Int
    var date: [String: Int]
    var local: [String: String]
    var photos: [URL]
    
    fileprivate init(withPhotoAlbum mock: PhotoAlbumMock) {
        photographer = mock.photographer
        artistName = mock.artistName
        artistId = mock.artistId
        date = mock.date
        local = mock.local
        photos = mock.photos
    }
}

private class PhotoAlbumMock {
    var photographer: String
    var artistName: String
    var artistId: Int
    var date: [String: Int]
    var local: [String: String]
    var photos: [URL]
    
    init(photographer: String,
         artistName: String,
         artistId: Int,
         date: [String: Int],
         local: [String: String],
         photos: [URL]) {
        self.photographer = photographer
        self.artistName = artistName
        self.artistId = artistId
        self.date = date
        self.local = local
        self.photos = photos
    }
}

private var allPhotoAlbumsMocks: [PhotoAlbumMock] = [
    PhotoAlbumMock(photographer: "Alguem",
                   artistName: "Chris Scott",
                   artistId: 1,
                   date: ["Dia": 1, "Mes": 12, "Ano": 2008],
                   local: ["Estado": "Brasilia", "Pais": "Brazil"],
                   photos: [URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!]
    ),
    PhotoAlbumMock(photographer: "Outro Alguem",
                   artistName: "Chris Scott",
                   artistId: 1,
                   date: ["Dia": 2, "Mes": 12, "Ano": 2008],
                   local: ["Estado": "Brasilia", "Pais": "Brazil"],
                   photos: [URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!,
                           URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!,
                           URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!]
    ),
    PhotoAlbumMock(photographer: "Alguem2",
                   artistName: "Maria Silva",
                   artistId: 2,
                   date: ["Dia": 3, "Mes": 11, "Ano": 2015],
                   local: ["Estado": "Rio de Janeiro", "Pais": "Brazil"],
                   photos: [URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!]
    ),
    PhotoAlbumMock(photographer: "Outro Alguem2",
                   artistName: "Maria Silva",
                   artistId: 2,
                   date: ["Dia": 4, "Mes": 11, "Ano": 2015],
                   local: ["Estado": "Rio de Janeiro", "Pais": "Brazil"],
                   photos: [URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                           URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                           URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                           URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                           URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                           URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!]
    ),
    PhotoAlbumMock(photographer: "Outro Alguem3",
                   artistName: "Maria Silva",
                   artistId: 2,
                   date: ["Dia": 4, "Mes": 12, "Ano": 2016],
                   local: ["Estado": "Rio Grande do Sul", "Pais": "Brazil"],
                   photos: [URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!,
                           URL(string: "https://pbs.twimg.com/profile_images/830236324967821312/RaZogipo_400x400.jpg")!]
    )
]

var allAlbums: [PhotoAlbum] {
    return [PhotoAlbum(withPhotoAlbum: allPhotoAlbumsMocks[1]), PhotoAlbum(withPhotoAlbum: allPhotoAlbumsMocks[3]), PhotoAlbum(withPhotoAlbum: allPhotoAlbumsMocks[4])]
}

var allSecondaryAlbums: [PhotoAlbum] {
    return [PhotoAlbum(withPhotoAlbum: allPhotoAlbumsMocks[0]), PhotoAlbum(withPhotoAlbum: allPhotoAlbumsMocks[2])]
}

class PhotoAlbumServer {
    static func takeSecondaryAlbum(by artistId: Int, onCompletion completionHandler: @escaping (PhotoAlbum?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                
                for album in allSecondaryAlbums {
                    if album.artistId == artistId {
                        completionHandler(album)
                    }
                }
            } else {
                completionHandler(nil)
            }
        }
    }
    
    static func takeotherAlbums(by artistId: Int, onCompletion completionHandler: @escaping ([PhotoAlbum]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            var outrosAlbuns: [PhotoAlbum] = []
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                
                for album in allAlbums {
                    
                    if album.artistId == artistId {
                        outrosAlbuns.append(album)
                        
                    }
                }
                completionHandler(outrosAlbuns)
            } else {
                completionHandler(nil)
            }
        }
    }
}
