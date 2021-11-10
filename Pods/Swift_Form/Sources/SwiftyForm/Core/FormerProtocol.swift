//
//  FormerProtocol.swift
//  SwiftyForm
//
//  Created by iOS on 2020/6/5.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

public protocol InlineForm{
    
    var inlineRowFormer: RowFormer { get }
    func editingDidBegin()
    func editingDidEnd()
}

public protocol ConfigurableInlineForm: InlineForm {
    
    associatedtype InlineCellType: UITableViewCell
}

extension ConfigurableInlineForm where Self: RowFormer {
    
    @discardableResult
    public func inlineCellSetup(_ handler: @escaping ((InlineCellType) -> Void)) -> Self {
        inlineRowFormer.cellSetup { handler($0 as! InlineCellType) }
        return self
    }
    
    @discardableResult
    public func inlineCellUpdate(update: ((InlineCellType) -> Void)) -> Self {
        update(inlineRowFormer.cellInstance as! InlineCellType)
        return self
    }
}


public protocol SelectorForm {
    
    func editingDidBegin()
    func editingDidEnd()
}

public protocol UpdatableSelectorForm: SelectorForm {
    
    associatedtype SelectorViewType: UIView
    var selectorView: SelectorViewType { get }
}

extension UpdatableSelectorForm where Self: RowFormer {
    
    @discardableResult
    public func selectorViewUpdate(update: ((SelectorViewType) -> Void)) -> Self {
        update(selectorView)
        return self
    }
}


public protocol Formable: SelectableForm, UpdatableForm, ConfigurableForm {
    
}

public protocol SelectableForm {
    
}

public extension SelectableForm where Self: RowFormer {
    
    @discardableResult
    func onSelected(_ handler: @escaping ((Self) -> Void)) -> Self {
        onSelected = {
            handler($0 as! Self)
        }
        return self
    }
}

public protocol UpdatableForm {
    
}

public extension UpdatableForm where Self: RowFormer {
    
    @discardableResult
    func update(_ handler: ((Self) -> Void)) -> Self {
        handler(self)
        update()
        return self
    }
    
    @discardableResult
    func onUpdate(_ handler: @escaping ((Self) -> Void)) -> Self {
        onUpdate = {
            handler($0 as! Self)
        }
        return self
    }
}

public protocol ConfigurableForm {
    
}

public extension ConfigurableForm where Self: RowFormer {
    
    @discardableResult
    func configure(handler: ((Self) -> Void)) -> Self {
        handler(self)
        return self
    }
}

public extension ConfigurableForm where Self: ViewFormer {
    
    @discardableResult
    func configure(handler: ((Self) -> Void)) -> Self {
        handler(self)
        return self
    }
    
    @discardableResult
    func update(_ handler: ((Self) -> Void)) -> Self {
        handler(self)
        self.update()
        return self
    }
}

