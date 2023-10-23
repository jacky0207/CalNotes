//
//  ImageUtil.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-21.
//

import UIKit

class ImageUtil {
    static let shared = ImageUtil()

    private init() {}

    func base64String(from image: UIImage) -> String? {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString()
    }

    func image(fromBase64 string: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: string),
              let image = UIImage(data: imageData) else {
            return nil
        }
        return image
    }
}
