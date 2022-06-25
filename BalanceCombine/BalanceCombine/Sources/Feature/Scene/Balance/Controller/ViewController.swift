//
//  ViewController.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private var contentView: BalanceViewProtocol
    private var viewModel: BalanceViewModelProtocol
    
    //MARK: - Constructor
    
    init(contentView: BalanceViewProtocol, viewModel: BalanceViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle
    
    override func loadView() {
        super.loadView()
        view = contentView as? BalanceView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerDelegates()
    }
}

//MARK: - Helpers

private extension ViewController {
    
    func registerDelegates() {
        contentView.delegate = self
        viewModel.delegate = self
    }
}

//MARK: - BalanceViewDelegate

extension ViewController: BalanceViewDelegate {
    
    func retryWasTapped() {
        viewModel.notify(event: .refresh(.initial  ))
    }
}

//MARK: - BalanceViewModelDelegate

extension ViewController: BalanceViewModelDelegate {
    
    func refreshBalanceBox(_ state: BalanceBoxView.State) {
        contentView.update(state: state)
    }
}
