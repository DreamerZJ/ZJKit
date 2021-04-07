//
//  ZJNext.swift
//  ZJKit
//
//  Created by micheal on 2021/4/7.
//

import Foundation

public protocol Next {}

extension Next where Self: Any {
    public func next(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copyOne = self
        try block(&copyOne)
        return copyOne
    }
}

extension Next where Self: AnyObject {

    public func next(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Next {}

extension CGRect: Next {}
extension CGPoint: Next {}
extension UIEdgeInsets: Next {}
extension CGSize: Next {}

extension Array: Next {}
extension Dictionary: Next {}
extension Set: Next {}
