//
//  UIControl+Extensions.swift
//  BalanceCombine
//
//  Created by Paolo Prodossimo Lopes on 19/06/22.
//

import UIKit
import Combine

extension UIControl {
    
    func publisher(for event: UIControl.Event) -> UIControl.InteractionPublisher {
        InteractionPublisher(control: self, event: event)
    }
    
    final class InteractionSubscription<S: Subscriber>: Subscription where S.Input == Void {
        
        //MARK: - Properties
        
        private let subscriber: S?
        private let control: UIControl
        private let event: UIControl.Event
        
        //MARK: - Constructor
        
        init(subscriber: S, control: UIControl, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            self.event = event
            
            self.control.addTarget(self, action: #selector(handleControlAction), for: self.event)
        }
        
        //MARK: - Subscription
        
        func request(_ demand: Subscribers.Demand) { }
        func cancel() { }
        
        //MARK: - Selector
        
        @objc private func handleControlAction(_ sender: UIControl) {
            _ = self.subscriber?.receive()
        }
    }
    
    struct InteractionPublisher: Publisher {
        
        //MARK: - Alias
        
        typealias Output = Void
        typealias Failure = Never
        
        //MARK: - Properties
        
        private let control: UIControl
        private let event: UIControl.Event
        
        //MARK: - Constructor
        
        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }
        
        
        //MARK: - Publisher
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
            
            let subscription = InteractionSubscription(
                subscriber: subscriber, control: control, event: event)
            
            subscriber.receive(subscription: subscription)
        }
    }
}
