//
//  BalanceBoxView+Constant.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import UIKit

extension BalanceBoxView {
    struct Constant {
        
        struct Text {
            typealias TYPE = String
            static let coder: TYPE = "init(coder:) has not been implemented"
            
            static let title: TYPE = "Your balance"
            static let value: TYPE = "$100.00"
            static let description: TYPE = "Last update: Today, 4:03 PM"
            
            static let loading: TYPE = "~~~"
            static let none: TYPE = "---"
        }
        
        struct Icon {
            typealias TYPE = String
            static let refresh: TYPE = "arrow.counterclockwise"
        }
        
        struct Font {
            typealias TYPE = CGFloat
            static let title: TYPE = 18
            static let value: TYPE = 14
            static let description: TYPE = 12
        }
        
        struct NumberStyle {
            typealias TYPE = CGFloat
            static let cornerRadius: TYPE = 8
            static let verticalSpacing: TYPE = 20
        }
        
        struct Margin {
            typealias TYPE = CGFloat
            static let horizontal: TYPE = 16
            static let vertical: TYPE = 10
        }
    }
}
