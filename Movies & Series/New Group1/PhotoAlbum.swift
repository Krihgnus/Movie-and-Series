import Foundation
import UIKit
    
struct PhotoAlbum {
    let fotografo: String
    let fotografado: String
    let fotografadoId: Int
    let data: [String: Int] // "Dia": 00, "Mes": 00, "Ano": 0000
    let local: [String: String] //"Estado": "BBBBB", "Pais": "CCCC"
    let fotos: [URL]
}

//Banco de dados de albums de fotos ficticios

//Fotos Laranja
let secondaryTestAlbum1: PhotoAlbum = PhotoAlbum(fotografo: "Alguem",
                                                 fotografado: "Joao Silva",
                                                 fotografadoId: 1,
                                                 data: ["Dia": 1, "Mes": 12, "Ano": 2008],
                                                 local: ["Estado": "Brasilia", "Pais": "Brazil"],
                                                 //COMENTADAS PARA TESTE DE MOSAICOS
                                                 fotos: [//URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                                                         //URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                                                         URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                                                         URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                                                         URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!,
                                                         URL(string: "https://wallpapercave.com/wp/DVoCGdt.jpg")!]
)

//Fotos Ciano
let otherAlbum1: PhotoAlbum = PhotoAlbum(fotografo: "Outro Alguem",
                                         fotografado: "Joao Silva",
                                         fotografadoId: 1,
                                         data: ["Dia": 2, "Mes": 12, "Ano": 2008],
                                         local: ["Estado": "Brasilia", "Pais": "Brazil"],
                                         fotos: [URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!,
                                                 URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!,
                                                 URL(string: "https://wallpaper.wiki/wp-content/uploads/2017/04/wallpaper.wiki-Free-Wallpapers-HD-Cyan-PIC-WPB0011264.jpg")!]
)

//Fotos Ciano - Ladrinho
let secondaryTestAlbum2: PhotoAlbum = PhotoAlbum(fotografo: "Alguem2",
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
)

//Fotos Preto
let otherAlbum2: PhotoAlbum = PhotoAlbum(fotografo: "Outro Alguem2",
                                         fotografado: "Maria Silva",
                                         fotografadoId: 2,
                                         data: ["Dia": 4, "Mes": 11, "Ano": 2015],
                                         local: ["Estado": "Rio de Janeiro", "Pais": "Brazil"],
                                         fotos: [URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                                                 URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!,
                                                 URL(string: "https://images.pexels.com/photos/6406/sun-moon-eclipse-march-2015.jpg?auto=compress&cs=tinysrgb&h=350")!]
)

//Albums
let allAlbums: [PhotoAlbum] = [otherAlbum1, otherAlbum2]

//Todos albuns secundarios
let allSecondaryPhotoAlbums: [PhotoAlbum] = [secondaryTestAlbum1, secondaryTestAlbum2]


//Class ficticia que representa o servidor que puxa os dados dos atores de um banco de dados atraves de requests
class PhotoAlbumServer {
    static func takeSecondaryAlbum(by artistId: Int, onCompletion completionHandler: @escaping (PhotoAlbum?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let sucesso = (shouldRandomizeResults) ? arc4random_uniform(2) == 0 : true
            
            if sucesso {
                
                for album in allSecondaryPhotoAlbums {
                    
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

