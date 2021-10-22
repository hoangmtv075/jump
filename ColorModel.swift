//
//  ColorModel.swift
//  Jump
//
//  Created by Thanh Hoang on 18/10/2021.
//

import UIKit

class ColorModel {
    
    let color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }
    
    class func shared() -> [ColorModel] {
        return [
            ColorModel(color: UIColor(hex: 0xF5E00D)),
            ColorModel(color: UIColor(hex: 0xFF7E02)),
            ColorModel(color: UIColor(hex: 0xEAC04A)),
            ColorModel(color: UIColor(hex: 0x38D349)),
            ColorModel(color: UIColor(hex: 0x8D13FC)),
            ColorModel(color: UIColor(hex: 0xFF007F)),
            ColorModel(color: UIColor(hex: 0x3BE2F6)),
            ColorModel(color: UIColor(hex: 0xF50700)),
            ColorModel(color: UIColor(hex: 0xFF00FF)),
            ColorModel(color: UIColor(hex: 0xF5E00D)),
            ColorModel(color: UIColor(hex: 0x4245E8)),
            ColorModel(color: UIColor(hex: 0x08FA08))
        ]
    }
}
