import Foundation

import UIKit
import SDWebImageSwiftUI

extension UIImageView {
    func loadImage(from url: URL) {
        sd_setImage(with: url, completed: nil)
    }
}
