import Foundation
import UIKit

class Utils {
    static func photoCount(_ photoAlbumsArray: [PhotoAlbum]) -> Int {
        var photos = 0
        for (_, photoAlbum) in photoAlbumsArray.enumerated() {
            photos += photoAlbum.fotos.count
        }
        return photos
    }
    
    static func numberToMonth(_ number: Int?) -> String {
        let months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        if let numero = number {
            let month = (numero - 1 >= 0 && numero - 1 < 12) ? months[numero - 1] : "Month not found"
            return month
        }
        return "Month not found"
    }
    
    static func arrCategoriesToString(_ array: [String]) -> String {
        var categories = ""
        for (indx, texto) in array.enumerated() {
            categories = (indx == 0) ? texto : "\(categories) | \(texto)"
        }
        return categories
    }
    
    static func reviewsToAverageStar(_ array: [Review]) -> Int {
        var media = 0
        for review in array {
            media += review.estrelas
        }
        return media / array.count
    }
}
