//
//  Double+Extension.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import Foundation

extension Double {
    var date: Date {
        Date(timeIntervalSince1970: self)
    }
}
