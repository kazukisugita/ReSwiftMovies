//
//  NSObject+className.swift
//  for_sure_selector_ios
//
//  Created by Tsubasa Hayashi on 2019/02/12.
//  Copyright © 2019 crea. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}
