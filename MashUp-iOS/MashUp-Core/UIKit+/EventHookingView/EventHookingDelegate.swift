//
//  EventHookingDelegate.swift
//  MashUp-Core
//
//  Created by Booung on 2022/06/12.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public protocol EventHookingDelegate: AnyObject {
    func touchesBegan(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?)
    func touchesCancelled(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?)
}

public extension EventHookingDelegate {
    func touchesBegan(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?) {}
    func touchesEnded(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?) {}
    func touchesMoved(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?) {}
    func touchesCancelled(_ view: UIView, touches: Set<UITouch>, with event: UIEvent?) {}
}

