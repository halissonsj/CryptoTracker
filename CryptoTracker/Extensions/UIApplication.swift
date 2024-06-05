//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
