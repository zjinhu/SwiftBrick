//
//  UILineView.swift
//  SwiftBrick
//
//  Created by iOS on 2020/9/2.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
// MARK: ===================================Factory: Dashed and Solid Lines=========================================
// MARK: ===================================工厂类:虚线 实线=========================================
/// Line view for drawing dashed or solid lines / 虚线/实线视图
public class UILineView: UIView {
    /// Line width / 线宽度
    public var lineWidth: CGFloat = Define.lineHeight{
        didSet{
            setNeedsDisplay()
        }
    }
    /// Line color / 线颜色
    public var lineColor: UIColor = .baseLine{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Left padding / 左侧内边距
    public var paddingLeft: CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Right padding / 右侧内边距
    public var paddingRight: CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Top padding / 顶部内边距
    public var paddingTop: CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Bottom padding / 底部内边距
    public var paddingBottom: CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Horizontal or vertical line / 横线 竖线
    public var isHorizontal: Bool = true{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Whether dashed line / 是否虚线
    public var isDash: Bool = false{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Dash segment length / 虚线长
    public var dashPointWidth: CGFloat = 3.0{
        didSet{
            setNeedsDisplay()
        }
    }
    /// Dash gap length / 虚线间距
    public var dashPointSpace: CGFloat = 1.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code / 绘制代码
        // Get graphics context / 获取上下文对象
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var bx: CGFloat = 0, by: CGFloat = 0, ex: CGFloat = 0, ey: CGFloat = 0;
        if isHorizontal {
            bx = paddingLeft
            by = CGFloat(Int(rect.size.height)/2)
            ex = rect.size.width - paddingRight
            ey = by
        } else {
            bx = CGFloat(Int(rect.size.width)/2)
            by = paddingTop
            ex = bx
            ey = rect.size.height - paddingBottom
        }
        // Draw middle dashed line / 画中间虚线
        let path    = CGMutablePath()
        let begin   = CGPoint(x: bx, y: by),
            end     = CGPoint(x: ex, y: ey)
        path.move(to: begin)
        path.addLine(to: end)
        // 2、 Add path to graphics context / 2、 添加路径到图形上下文
        context.addPath(path)
        // 3、 Set state / 3、 设置状态
        
        context.setLineWidth(lineWidth)
        context.setStrokeColor(lineColor.cgColor)
        if isDash {
            context.setLineDash(phase: 0, lengths: [dashPointWidth, dashPointSpace])
        }
        // 4、 Draw path to graphics context / 4、 绘制图像到指定图形上下文
        context.drawPath(using: .fillStroke)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    /// Quick line creation convenience initializer / 快速画线
    /// - Parameters:
    ///   - horizontal: bool - horizontal or vertical / bool 横线 竖线
    ///   - width: Line width / 线宽
    ///   - color: Line color / 颜色
    ///   - dash: Whether dashed / 是否虚线
    ///   - dashWidth: Dash segment length / 虚线长
    ///   - dashSpace: Dash gap length / 虚线间隔
    public convenience init(horizontal: Bool = true,
                            width: CGFloat = Define.lineHeight,
                            color: UIColor = .baseLine,
                            dash: Bool = false,
                            dashWidth: CGFloat = 1,
                            dashSpace: CGFloat = 1){
        self.init()
        isHorizontal = horizontal
        isDash = dash
        lineWidth = width
        lineColor = color
        if dash {
            dashPointWidth = dashWidth
            dashPointSpace = dashSpace
        }
    }
}
