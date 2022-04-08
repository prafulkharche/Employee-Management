//
//  UIImageViewExtenstion.swift
//  QuixoteTest
//
//  Created by Apple on 07/04/22.
//

import Foundation
import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
    
extension UIImage {
        func toPngString() -> String? {
            let data = self.pngData()
            return data?.base64EncodedString(options: .endLineWithLineFeed)
        }
      
        func toJpegString(compressionQuality cq: CGFloat) -> String? {
            let data = self.jpegData(compressionQuality: cq)
            return data?.base64EncodedString(options: .endLineWithLineFeed)
        }
    
}


