//
//  EventHookingStackView.swift
//  MashUp-Core
//
//  Created by Booung on 2022/06/12.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public class EventHookingStackView: UIStackView {
    
    public weak var delegate: EventHookingDelegate?
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.touchesBegan(self, touches: touches, with: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.touchesEnded(self, touches: touches, with: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.touchesMoved(self, touches: touches, with: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.touchesCancelled(self, touches: touches, with: event)
    }
    
}
