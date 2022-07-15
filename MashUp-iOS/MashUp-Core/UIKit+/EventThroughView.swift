//
//  EventThroughView.swift
//  MashUp-Core
//
//  Created by Booung on 2022/07/15.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public class EventThroughView: UIView {
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestView = super.hitTest(point, with: event)
        
        return hitTestView === self ? nil : hitTestView
    }
    
}

public class EventThroughStackView: UIStackView {
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestView = super.hitTest(point, with: event)
        
        return hitTestView == self ? nil : hitTestView
    }
    
}

public class EventThroughScrollView: UIScrollView {
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestView = super.hitTest(point, with: event)
        
        return hitTestView == self ? nil : hitTestView
    }
    
}
