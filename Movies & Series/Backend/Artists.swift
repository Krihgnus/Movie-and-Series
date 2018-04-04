import Foundation
import UIKit

struct Artist {
    let identifier: Int
    let name: String
    let profissao: String
    let dataNascimento: [String: String]
    let localNascimento: [String: String]
    let filmes: [String]
    let series: [String]
    let imagemCapa: URL
    let descricao: String
    let AlbumSecundario: PhotoAlbum
    let outrosAlbums: [PhotoAlbum]
}
