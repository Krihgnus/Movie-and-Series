import Foundation
import UIKit
import SDWebImage

class CategoryCell: UITableViewCell {
    static let identifier = "categoryCell"
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImage.image = nil
        categoryName.text = nil
    }
    
    func configure(_ category: String) { //FUNC CONFIGURE(_ FILM: OBJ FILME) {
        self.selectionStyle = .none
        categoryName.text = category //CATEGORYNAME.TEXT = FILM.NAME (OU SEMELHANTE)
        categoryImage.sd_setImage(with: URL(string: "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAHQAugMBIgACEQEDEQH/xAAbAAADAQEAAwAAAAAAAAAAAAACAwQBAAUGB//EACcQAQEBAAEDAwQBBQAAAAAAAAACARIDEWEFBiEEMZPSQRMUJDRU/8QAGAEBAQEBAQAAAAAAAAAAAAAAAgEDAAT/xAAXEQEBAQEAAAAAAAAAAAAAAAAAAREx/9oADAMBAAIRAxEAPwD5VJ8YVGHw9ceOmxh8YVGHxjSM6bGKIwrp4ojDjOmRJ0SCMOnGkZ1syZkunDMwpAtDkt4jzHdlxC9kOzh3YO45YRUlVKmsKvEKJbwi8VXhN4zpxJeJ7xXeJrZ1pE14ReKbT1gVpCLLNsANNMg+CIPhYNUQfBEKOm0jOn9NTCeFEfZpGVOjD5Jg+WkZ0ycHmBkeHAE5zXOZoNHrNc4rcKvDqJoaUIsi1Fk9QKcTWm6im09s60iayLUWntnWsIss2/sWJjg+E8afGuiVTCjppY1RGtIzqrpnwm6eqI1pGdUQfOp40+d+GkZ06TM0qfsOdKBhmOD38u7+VQQN1vfyHUUNFUPdKpFhdp7069IsK0hNp7OtPes60hNp7OvSLZ1pCbLHYBPBQdGp506NSOqmFEJY0+NaQLFUao6epI0+KaRnYrnTp1LFHTRys7FOaOdTzRmUYYd3b3KyvLuTtTDd0O0DaDtOdja0utZVF1SUpA3pF6O6IumdaSF3pF6ZekXoVpIXep7NvSL1nThdgbegDWjZ02NInTJ10dVMafFJZ06KOBVcUdFI4o+KOVnYrmjppHNmzZyhYrmzMtLNjyy0cU8nck/NvNdTD+YdorbDtu12Dqi6sO2VVjaUjbom6dVlXQWnIy6IvRXRN0FOQF0VWirSa0bTkDWg7trQdwN06ZOkZpk66OqidNmk2aZNFKNiuaNmkk0bNEFiuaMm0k0ZlnKNiubHl/KSaHlro4p5t5+U3NvNdTFG35Dtkc2bbtXDdsuqL2wVQ6sg6oqqDVl1SWlI2qJum1RVUFp4yqKrW7pe6OlGVoG1oO4k7BzpOaPNTVp86PKIzR5paNijKMmvhNlDyi1MVZXkeWlyh5S6NirK8iy0uWPLXRxRzdzI5u5rqYfzZtk82c3auG7YKryXtg201cHVAqgbQNpLVkFVF1TNoG6BRu0Xuu3QbqFI7dYzdZ3TVYLHOSKPBY1xDRYPHOVBYPHOWIJuOcqVrnOVHM3WOc5n8M1zkWA0OuchA15b2p9B9N6l6xn0/wBZG30v6N3xytn5zt2+c+f5c4as69y32h6H9v7Ovz9T9i99o+if8lfn6n7OcDSM32j6H2/06/P1P2Pn2b6D2z/Cr8/U/ZzkV//Z"), completed: nil) //CATEGORYIMAGE.SD_SETIMAGE(WITH: (FILM.URLLINK (OU SEMELHANTE)), COMPLETED: NIL)
    }
}
