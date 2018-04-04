import Foundation
import UIKit

struct PhotoAlbum {
    let fotografo: String
    let fotografado: String
    let data: [String: String] // DIA / MES / ANO
    let local: [String: String] //ESTADO / PAIS
    let fotos: [URL]
    
    //let ultimaVisualizacao: [String: String]
}
