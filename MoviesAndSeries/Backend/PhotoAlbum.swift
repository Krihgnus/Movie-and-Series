import Foundation
import UIKit
    
struct PhotoAlbum {
    var fotografo: String
    var fotografado: String
    var fotografadoId: Int
    var data: [String: Int]
    var local: [String: String]
    var fotos: [URL]
    
    fileprivate init(withPhotoAlbum mock: PhotoAlbumMock) {
        fotografo = mock.fotografo
        fotografado = mock.fotografado
        fotografadoId = mock.fotografadoId
        data = mock.data
        local = mock.local
        fotos = mock.fotos
    }
}

private class PhotoAlbumMock {
    var fotografo: String
    var fotografado: String
    var fotografadoId: Int
    var data: [String: Int]
    var local: [String: String]
    var fotos: [URL]
    
    init(fotografo: String,
         fotografado: String,
         fotografadoId: Int,
         data: [String: Int],
         local: [String: String],
         fotos: [URL]) {
        self.fotografo = fotografo
        self.fotografado = fotografado
        self.fotografadoId = fotografadoId
        self.data = data
        self.local = local
        self.fotos = fotos
    }
}

private var allPhotoAlbumsMocks: [PhotoAlbumMock] = [
    PhotoAlbumMock(fotografo: "Alguem",
                   fotografado: "Chris Scott",
                   fotografadoId: 1,
                   data: ["Dia": 1, "Mes": 12, "Ano": 2008],
                   local: ["Estado": "Brasilia", "Pais": "Brazil"],
                   fotos: [URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                           URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!]
    ),
    PhotoAlbumMock(fotografo: "Outro Alguem",
                   fotografado: "Chris Scott",
                   fotografadoId: 1,
                   data: ["Dia": 2, "Mes": 12, "Ano": 2008],
                   local: ["Estado": "Brasilia", "Pais": "Brazil"],
                   fotos: [URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!,
                           URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!,
                           URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!]
    ),
    PhotoAlbumMock(fotografo: "Alguem2",
                   fotografado: "Maria Silva",
                   fotografadoId: 2,
                   data: ["Dia": 3, "Mes": 11, "Ano": 2015],
                   local: ["Estado": "Rio de Janeiro", "Pais": "Brazil"],
                   fotos: [URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!,
                           URL(string: "https://st.depositphotos.com/1892835/3966/i/950/depositphotos_39668349-stock-photo-cyan-background-wallpaper-texture-or.jpg")!]
    ),
    PhotoAlbumMock(fotografo: "Outro Alguem2",
                   fotografado: "Maria Silva",
                   fotografadoId: 2,
                   data: ["Dia": 4, "Mes": 11, "Ano": 2015],
                   local: ["Estado": "Rio de Janeiro", "Pais": "Brazil"],
                   fotos: [URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                           URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                           URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!]
    )
]

var allAlbums: [PhotoAlbum] {
    return [PhotoAlbum(withPhotoAlbum: allPhotoAlbumsMocks[1]), PhotoAlbum(withPhotoAlbum: allPhotoAlbumsMocks[3])]
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
                    if album.fotografadoId == artistId {
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
                    
                    if album.fotografadoId == artistId {
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
