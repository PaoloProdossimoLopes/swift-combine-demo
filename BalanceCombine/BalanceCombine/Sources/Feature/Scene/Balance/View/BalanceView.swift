//
//  BalanceView.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import UIKit

protocol BalanceViewDelegate: AnyObject {
    func retryWasTapped()
}

protocol BalanceViewProtocol {
    var delegate: BalanceViewDelegate? { get set }
    func update(state: BalanceBoxView.State)
}

final class BalanceView: UIView, BalanceViewProtocol {
    
    //MARK: - Properties
    
    weak var delegate: BalanceViewDelegate?
    
    //MARK: - UI Compoents
    
    private lazy var balanceBox: BalanceBoxView = {
        let box = BalanceBoxView()
        box.delegate = self
        return box
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(state: BalanceBoxView.State) {
        balanceBox.update(state: state)
    }
    
    private func commonInit() {
        configureStyle()
        configureHierarcy()
        configureConstraints()
    }
    
    private func configureHierarcy() {
        addSubview(verticalStack)
        
        [balanceBox, UIView()]
            .forEach(verticalStack.addArrangedSubview(_:))
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureStyle() {
        backgroundColor = .black
    }
}

//MARK: - BalanceBoxViewDelegate
extension BalanceView: BalanceBoxViewDelegate {
    func retryWasTapped(_ button: UIButton, in box: BalanceBoxViewProtocol) {
        delegate?.retryWasTapped()
    }
}

//MARK: - Constants
private extension BalanceView {
    struct Constant {
        
    }
}
