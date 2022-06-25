//
//  BalanceBoxView.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 18/06/22.
//

import UIKit
import Combine

protocol BalanceBoxViewDelegate: AnyObject {
    func retryWasTapped(_ button: UIButton, in box: BalanceBoxViewProtocol)
}

protocol BalanceBoxViewProtocol {
    func update(state: BalanceBoxView.State)
    func update(viewData: BalanceBoxView.ViewData)
}

final class BalanceBoxView: UIView {
    
    //MARK: - Delegate
    
    weak var delegate: BalanceBoxViewDelegate?
    
    //MARK: - Properties
    
    @Published private var viewData: ViewData = .init()
    @Published private var state: State = .none
    
    private var cancellable: Set<AnyCancellable> = .init()
    
    //MARK: - UICompoents
    
    private(set) lazy var balanceTitle: UILabel = {
        let label = UILabel()
        label.text = viewData.title
        label.font = .systemFont(ofSize: Constant.Font.title, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var balanceValue: UILabel = {
        let label = UILabel()
        label.text = viewData.value
        label.font = .systemFont(ofSize: Constant.Font.value, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var balanceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constant.Font.description, weight: .thin)
        label.textColor = .white
        label.text = viewData.description
        return label
    }()
    
    private(set) lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: Constant.Icon.refresh), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private(set) lazy var balanceValueOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Constant.NumberStyle.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constant.NumberStyle.verticalSpacing
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Constructor
    
    init(viewData: ViewData = .init()) {
        self.viewData = viewData
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.Text.coder)
    }
    
}

//MARK: - BalanceBoxViewProtocol

extension BalanceBoxView: BalanceBoxViewProtocol {
    
    func update(state: State) {
        self.state = state
    }
    
    func update(viewData: ViewData) {
        self.viewData = viewData
    }
}

//MARK: - ViewCode
extension BalanceBoxView: ViewCode {
    
    func configureHierarchy() {
        [balanceTitle, balanceValue, balanceDescriptionLabel]
            .forEach(verticalStack.addArrangedSubview)
        
        [verticalStack, UIView(), refreshButton]
            .forEach( horizontalStack.addArrangedSubview)
        
        [horizontalStack, balanceValueOverlayView]
            .forEach(addSubview)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontal),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontal),
            
            balanceValueOverlayView.topAnchor.constraint(equalTo: balanceValue.topAnchor , constant: -Constant.Margin.vertical),
            balanceValueOverlayView.leadingAnchor.constraint(equalTo: balanceValue.leadingAnchor),
            balanceValueOverlayView.trailingAnchor.constraint(equalTo: balanceValue.trailingAnchor),
            balanceValueOverlayView.bottomAnchor.constraint(equalTo: balanceValue.bottomAnchor, constant: Constant.Margin.vertical),
            
            bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor)
        ])
    }
    
    func configureStyle() {
        backgroundColor = .black
    }
}

//MARK: - Helpers
private extension BalanceBoxView {
    func commonInit() {
        registerSubscription()
        configureViewCode()
    }
    
    func registerSubscription() {
        $state
            .sink(receiveValue: onHandleState)
            .store(in: &cancellable)
        
        $viewData
            .sink(receiveValue: onHandleViewData)
            .store(in: &cancellable)
        
        refreshButton
            .publisher(for: .touchUpInside)
            .sink(receiveValue: retryButtonOnHandler)
            .store(in: &cancellable)
        
        NotificationCenter.default
            .publisher(for: UIApplication.willResignActiveNotification)
            .sink { [weak self] _ in self?.onHandleState(.idle) }
            .store(in: &cancellable)
        
        NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in self?.onHandleState(.none) }
            .store(in: &cancellable)
    }
    
    func onHandleState(_ state: State) {
        switch state {
        case .none:
            onNoneHandler()
            
        case .loading:
            onLoadingHandler()
            
        case .idle:
            onIdleHandler()
            
        case .failure(let failure):
            onFailureHandler(failure)
            
        case .success(let success):
            onSuccessHandler(success)
            
        case .nonIdle:
            onNoneHandler()
        }
    }
    
    func onHandleViewData(_ viewData: ViewData) {
        balanceValue.text = viewData.value
        balanceTitle.text = viewData.title
        balanceDescriptionLabel.text = viewData.description
    }
    
    func onNoneHandler() {
        balanceValue.text = Constant.Text.none
        balanceDescriptionLabel.textColor = .white
        balanceValueOverlayView.isHidden = true
    }
    
    func onLoadingHandler() {
        balanceValue.text = Constant.Text.loading
        balanceDescriptionLabel.textColor = .white
        balanceValueOverlayView.isHidden = true
    }
    
    func onIdleHandler() {
        balanceValueOverlayView.isHidden = false
    }
    
    func onNonIdleHandler() {
        balanceValueOverlayView.isHidden = true
    }
    
    func onFailureHandler(_ failure: String) {
        balanceDescriptionLabel.text = failure
        balanceDescriptionLabel.textColor = .red
        balanceValueOverlayView.isHidden = true
    }
    
    func onSuccessHandler(_ success: String) {
        balanceValue.text = success
        balanceDescriptionLabel.textColor = .white
        balanceDescriptionLabel.text = viewData.description
        balanceValueOverlayView.isHidden = true
    }
    
    func retryButtonOnHandler() {
        delegate?.retryWasTapped(refreshButton, in: self)
    }
}
