//
//  UIApplication+Extension.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
