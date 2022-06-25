//
//  Coordinator.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import Foundation

protocol Coordinator: AnyObject {
    var childrens: [Coordinator] { get }
    func start()
}
