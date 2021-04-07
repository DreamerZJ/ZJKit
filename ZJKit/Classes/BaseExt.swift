//
//  BaseExt.swift
//  ZJKit
//
//  Created by micheal on 2021/4/7.
//

import Foundation

// MARK: - 可拓展协议相关
/// 包含范型对象的结构体
public struct ZJBaseExt<Base> {
    public let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

/// 可拓展协议（支持zj属性拓展）
public protocol ZJExtEnableProtocol {
    associatedtype BaseType
    var zj: BaseType { get }
}

extension ZJExtEnableProtocol {
    public var zj: ZJBaseExt<Self> {
        return ZJBaseExt.init(self)
    }
}

// MARK: - 具体类型对象拓展实现

extension ZJBaseExt where Base == String {

    /// 指定下标范围字符串
    /// - Parameters:
    ///   - from: 起始下标
    ///   - to: 结束下标
    /// - Returns: 字符串
    public func subStr(_ from: Int, _ to: Int) -> String? {
        let originalStr = base
        guard from >= 0 && to <= base.count && to >= from else {
            return nil
        }
        let range = NSRange.init(location: from, length: to - from + 1)
        if let subRange = Range.init(range, in: base) {
            return String.init(originalStr[subRange])
        }
        return nil
    }
}

extension ZJBaseExt where Base: UIImageView {

}

extension String: ZJExtEnableProtocol{}


