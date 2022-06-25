//
//  ViewCode.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 19/06/22.
//

protocol ViewCode: AnyObject {
    
    func configureViewCode()
    func configureStyle()
    func configureHierarchy()
    func configureConstraints()
}

//MARK: - Default
extension ViewCode {
    
    func configureViewCode() {
        configureStyle()
        configureHierarchy()
        configureConstraints()
    }
    
    func configureStyle() { /*Non required*/ }
}
