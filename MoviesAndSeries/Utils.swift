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
            return months[numero]
        } else {
            return "Month not found"
        }
    }
}
