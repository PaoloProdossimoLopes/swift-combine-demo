//
//  BalanceViewModel.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import Foundation
import Combine

protocol BalanceViewModelDelegate: AnyObject {
    func refreshBalanceBox(_ state: BalanceBoxView.State)
}

protocol BalanceViewModelProtocol {
    var delegate: BalanceViewModelDelegate? { get set }
    func notify(event: BalanceViewModel.Event)
}

final class BalanceViewModel: BalanceViewModelProtocol {
    
    //MARK: - Properties
    
    weak var delegate: BalanceViewModelDelegate?
    private let service: BalanceServiceProtocol
    
    //MARK: - Constructor
    
    init(service: BalanceServiceProtocol) {
        self.service = service
    }
    
    //MARK: - Methods
    
    func notify(event: Event) {
        onNotifyHandle(event: event)
    }
}

//MARK: - Helper
private extension BalanceViewModel {
    
    func onNotifyHandle(event: Event) {
        switch event {
        case .refresh(let option):
            onRefreshHandler(event: option)
        }
    }
    
    func onRefreshHandler(event: Refresh) {
        switch event {
        case .initial:
            onInitialRefresh()
            
        case .secondary:
            onSecondaryRefresh()
        }
    }
    
    func onUpdate(_ option: Delegate) {
        switch option {
        case .boxState(let boxState):
            self.delegate?.refreshBalanceBox(boxState)
        }
    }
    
    func onInitialRefresh() {
        onUpdate(.boxState(.loading))
        fetchBalance()
    }
    
    func onSecondaryRefresh() {
        onUpdate(.boxState(.loading))
        fetchBalance()
    }
    
    func fetchBalance() {
        DispatchQueue.main.async {
            if Bool.random() {
                self.onUpdate(.boxState(.success("$200")))
            } else {
                self.onUpdate(.boxState(.failure("API Fail")))
            }
        }
    }
}
