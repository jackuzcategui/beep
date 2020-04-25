//
//  UIFont+extensions.swift
//  Beep
//
//  Created by Jack Uzcategui on 25/04/2020.
//  Copyright © 2020 __jackdaw__. All rights reserved.
//

import UIKit

extension UIFont {
    // Family: LCD Font names: ["LCDMonoBold"]
    static func lcdFont(with size: CGFloat) -> UIFont {
        return UIFont(name: "LCDMonoBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
