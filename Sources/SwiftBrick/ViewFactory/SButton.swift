//
//  SButton.swift
//  SwiftBrick
//
//  Created by iOS on 2021/11/25.
//  Copyright © 2021 狄烨 . All rights reserved.
//

import UIKit
class SButton: UIButton{
    ///别问我为什么这么写按钮触发逻辑,UIButton也是这样的
    var backgroundColorForNormal: UIColor?{
        didSet {
            backgroundColor = backgroundColorForNormal
        }
    }
    
    var backgroundColorForSelected: UIColor?
    
    var backgroundColorForHighlighted: UIColor?
    
    var backgroundColorForDisabled: UIColor?
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = backgroundColorForNormal {
                    backgroundColor = color
                }
            }
            else {
                if let color = backgroundColorForDisabled {
                    backgroundColor = color
                }
            }
        }
    }
    
    override var isSelected: Bool{
        didSet {
            if isSelected {
                if let color = backgroundColorForSelected {
                    backgroundColor = color
                }
            }
            else {
                if let color = backgroundColorForNormal {
                    backgroundColor = color
                }
            }
        }
    }
    
    override var isHighlighted: Bool{
        didSet {
            if isHighlighted {
                if isSelected{
                    if let color = backgroundColorForNormal {
                        backgroundColor = color
                    }
                }else{
                    if let color = backgroundColorForHighlighted {
                        backgroundColor = color
                    }
                }
            }
            else {
                if isSelected{
                    if let color = backgroundColorForSelected {
                        backgroundColor = color
                    }
                }else{
                    if let color = backgroundColorForNormal {
                        backgroundColor = color
                    }
                }
            }
        }
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        switch state {
        case .disabled:
            backgroundColorForDisabled = color
        case .normal:
            backgroundColorForNormal = color
        case .highlighted:
            backgroundColorForHighlighted = color
        case .selected:
            backgroundColorForSelected = color
        default:
            backgroundColorForNormal = color
        }
    }
    
    //MARK: --Touch事件监听
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if isSelected{
            if let color = backgroundColorForNormal {
                backgroundColor = color
            }
        }else{
            if let color = backgroundColorForHighlighted {
                backgroundColor = color
            }
        }
        return true
    }
    
    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if isSelected{
            if let color = backgroundColorForNormal {
                backgroundColor = color
            }
        }else{
            if let color = backgroundColorForHighlighted {
                backgroundColor = color
            }
        }
        return true
    }
    
    override open func cancelTracking(with event: UIEvent?) {
        if isSelected{
            if let color = backgroundColorForSelected {
                backgroundColor = color
            }
        }else{
            if let color = backgroundColorForNormal {
                backgroundColor = color
            }
        }
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if isSelected{
            if let color = backgroundColorForSelected {
                backgroundColor = color
            }
        }else{
            if let color = backgroundColorForNormal {
                backgroundColor = color
            }
        }
        
    }
}
