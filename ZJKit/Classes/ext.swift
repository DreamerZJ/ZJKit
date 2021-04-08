//
//  ext.swift
//  Pods
//
//  Created by micheal on 2021/3/3.
//

import Foundation

// MARK: - Int扩展
// point转pixel
public extension Int {

    var pixel: CGFloat {
        let mod = CGFloat(self % 3) / scale
        return CGFloat(self / 3) + mod
    }

    var pixel1: CGFloat {
        return CGFloat(self)*4/3
    }
}

// MARK: - NSObject扩展
public extension NSObject {

    /// 方法交换
    /// - Parameters:
    ///   - originalSelector: 原始方法
    ///   - swizzledSelector: 待交换方法
    class func zj_swizzledInstanceMethod(_ originalSelector:Selector, swizzledSelector:Selector) {
        guard let originalMethod = class_getInstanceMethod(self, originalSelector), let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else { return }
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

// MARK: - UIbutton扩展
private var touchEdgeInsetsKey: Void?
private var intervalKey: Void?
public extension UIButton {

    // MARK: - 扩充点击区域
    var enlargeEdgeInsets: UIEdgeInsets {

        set {
            objc_setAssociatedObject(self, &touchEdgeInsetsKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }

        get {
            guard let edgeInsets = objc_getAssociatedObject(self, &touchEdgeInsetsKey) as? UIEdgeInsets else { return UIEdgeInsets.zero }
            return edgeInsets
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHidden || !isUserInteractionEnabled || alpha < 0.01 || !(self.point(inside: point, with: event)) {
            return nil
        }
        // 原逻辑
        for subView in subviews.reversed() {
            if let hitView = subView.hitTest(subView.convert(point, from: self), with: event) {
                return hitView
            }
        }
        // 扩充区域
        let newRect = bounds.insetBy(dx: enlargeEdgeInsets.left, dy: enlargeEdgeInsets.top)
        if newRect.contains(point) {
            return self
        }
        return nil
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = bounds.insetBy(dx: enlargeEdgeInsets.left, dy: enlargeEdgeInsets.top)
        if (rect.equalTo(self.bounds)) {
            return super.point(inside: point, with: event)
        }
        return rect.contains(point)
    }

    // MARK: - 防连续重复点击
    var acceptInterval: TimeInterval {
        set {
            objc_setAssociatedObject(self, &intervalKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }

        get {
            guard let time = objc_getAssociatedObject(self, &intervalKey) as? TimeInterval else { return TimeInterval.zero }
            return time
        }
    }


    class func exchangeMethod() {
        // 系统方法
        let sysFunc = #selector(UIButton.sendAction(_:to:for:))
        // 自定义方法
        let myFunc = #selector(UIButton.customSendAction(_:to:for:))
        zj_swizzledInstanceMethod(sysFunc, swizzledSelector: myFunc)
    }

    @objc func resetState() {
        isEnabled = true
    }

    @objc func customSendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if !isEnabled { return }
        if isEnabled {
            if acceptInterval > 0 {
                customSendAction(action, to: target, for: event)
                isEnabled = false
                self.perform(#selector(resetState), with: self, afterDelay: acceptInterval)
            } else {
                customSendAction(action, to: target, for: event)
            }
        }
    }
}

private var actionKey: Void?
public extension UIButton {

    var block: ((UIButton) -> Void)? {
        get {
            objc_getAssociatedObject(self, &actionKey) as? (UIButton) -> Void
        }

        set {
            objc_setAssociatedObject(self, &actionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    @objc func touchAction() {
        self.block?(self)
    }

    /// 添加事件block
    /// - Parameters:
    ///   - block: 事件block
    ///   - event: 事件类型
    func addActionBlock(_ block: @escaping ((UIButton) -> Void), for event: UIControlEvents = .touchUpInside) {
        self.block = block
        self.addTarget(self, action: #selector(self.touchAction), for: event)
    }


    /// 快速创建带事件block的UIButton
    /// - Parameters:
    ///   - action: 事件block
    ///   - event: 事件类型
    /// - Returns: 按钮
    class func button(with action: @escaping ((UIButton) -> Void), for event: UIControlEvents = .touchUpInside) -> UIButton {
        let btn = UIButton()
        btn.addActionBlock(action, for: event)
        return btn
    }
}

// MARK: - String扩展
public extension String {
    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    /// 固定长度的随机字符串
    /// - Parameter len: 长度
    /// - Returns: 随机字符串
    static func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}

// MARK: - Timer扩展
public extension Timer {

    /// 不存在循环引用的计时器调用方式
    /// - Parameters:
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复，默认为true
    ///   - block: 回调block
    /// - Returns: 计时器
    class func start(timeInterval: TimeInterval, repeats: Bool = true, block: @escaping (Timer) -> Void) -> Timer? {
        if #available(iOS 10.0, *) {
            let time = Timer.init(timeInterval: timeInterval, repeats: repeats, block: block)
            RunLoop.current.add(time, forMode: .commonModes)
            return time
        }
        return nil
    }
}
