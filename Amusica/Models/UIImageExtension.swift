//
//  UIImageExtension.swift
//  Amusica
//
//  Getting average color of the artwork for
//  better UI/UX
//
//  Created by Amir Mahdi Abravesh on 10/6/23.
//

import Foundation
import UIKit

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0] < 130 ? bitmap[0] + 125 : 0) / 255,   // if the red color exceeds from 255 the app will crash
                       green: CGFloat(bitmap[1] < 130 ? bitmap[1] + 125 : 0) / 255, // if the green color exceeds from 255 the app will crash
                       blue: CGFloat(bitmap[2] < 130 ? bitmap[2] + 125 : 0) / 255,  // if the blue color exceeds from 255 the app will crash
                       alpha: CGFloat(bitmap[3]) / 255)
        
        // for the bright colors I think the black is good
        // but I have to do more testin to see if every song
        // is ok with this coloring scheme that I'm going for
    }
}
