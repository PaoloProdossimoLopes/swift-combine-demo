//
//  BalanceViewModel+Models.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 19/06/22.
//

extension BalanceViewModel {
    enum Event {
        case refresh(Refresh)
    }
    
    enum Delegate {
        case boxState(BalanceBoxView.State)
    }
    
    enum Refresh {
        case initial
        case secondary
    }
}
