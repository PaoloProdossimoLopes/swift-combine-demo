//
//  BalanceBoxView+State.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//


extension BalanceBoxView {
    enum State {
        case none
        case loading
        case idle
        case nonIdle
        case failure(String)
        case success(String)
    }
}
