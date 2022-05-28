//
//  SimpleView.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2022/3/15.
//  Copyright © 2022 狄烨 . All rights reserved.
//

import UIKit

class BorderView: UIView {
    
    var border: CAShapeLayer?
    
    var cornerRadius: CGFloat = 5{
        didSet{
            drawBoader()
        }
    }//圆角
    var borderWidth: CGFloat = 1{
        didSet{
            drawBoader()
        }
    }//边框宽度
    var borderColor: UIColor = .red{
        didSet{
            drawBoader()
        }
    }//边框颜色
    var dashWidth: Float = 3{
        didSet{
            drawBoader()
        }
    }//虚线长
    var dashSpace: Float = 3{
        didSet{
            drawBoader()
        }
    }//虚线间距

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawBoader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawBoader(){
        layoutIfNeeded()
        if let b = border{
            b.removeFromSuperlayer()
        }
        
        border = CAShapeLayer()
        //虚线的颜色
        border?.strokeColor = borderColor.cgColor
        //填充的颜色
        border?.fillColor = UIColor.clear.cgColor
        let path = UIBezierPath.init(roundedRect: bounds, cornerRadius: cornerRadius)
        //设置路径
        border?.path = path.cgPath
        border?.frame = bounds
        //虚线的宽度
        border?.lineWidth = borderWidth
        //虚线的间隔
        border?.lineDashPattern = [NSNumber(value: dashWidth), NSNumber(value: dashSpace)]
        layer.addSublayer(border!)
    }
}

class MoveView: BorderView {
    //记录左上角箭头移动的起始位置
    var startLeftTopPoint: CGPoint?
    //记录右上角箭头移动的起始位置
    var startRightTopPoint: CGPoint?
    //记录左下角箭头移动的起始位置
    var startLeftBottomPoint: CGPoint?
    //记录右下角箭头移动的起始位置
    var startRightBottomPoint: CGPoint?
    //记录透明区域移动的起始位置
    var startMovePoint: CGPoint?
    
    var isShowImage = true
//    lazy var rectangleView = UIView()
    
    let imageSize: CGFloat = 20//箭头的宽高
    let imageSideLength: CGFloat = 20//箭头的宽高
    let imageMinSpace: CGFloat = 20
    let imagePadding: CGFloat = 10
    let bordWidth: CGFloat = 2
    
    //左上角 左右滑动手势
    lazy var leftTopImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "Image0")
        let g = UIPanGestureRecognizer(target: self, action: #selector(moveCorner(_:)))
        i.addGestureRecognizer(g)
        return i
    }()
    //右上角 点击关闭
    lazy var rightTopImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "Image1")
        let g = UIPanGestureRecognizer(target: self, action: #selector(moveCorner(_:)))
        i.addGestureRecognizer(g)
        return i
    }()
    //左下角 上下滑动手势
    lazy var leftBottomImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "Image2")
        let g = UIPanGestureRecognizer(target: self, action: #selector(moveCorner(_:)))
        i.addGestureRecognizer(g)
        return i
    }()
    //右下角 斜角移动手势
    lazy var rightBottomImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "Image3")
        let g = UIPanGestureRecognizer(target: self, action: #selector(moveCorner(_:)))
        i.addGestureRecognizer(g)
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        let pan = UIPanGestureRecognizer(target: self, action: #selector(moveView(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        addGestureRecognizer(pan)
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addImageViews(){
        superview?.addSubview(leftTopImageView)
        superview?.addSubview(rightTopImageView)
        superview?.addSubview(leftBottomImageView)
        superview?.addSubview(rightBottomImageView)
        
        let rect = frame
        
//        rectangleView.frame = frame
        
        let x = rect.origin.x
        let y = rect.origin.y
        let w = rect.size.width
        let h = rect.size.height
        
        leftTopImageView.frame = CGRect(x: x - imageSize/2, y: y - imageSize/2, width: imageSize, height: imageSize)
        rightTopImageView.frame = CGRect(x: x + w - imageSize/2, y: y - imageSize/2, width: imageSize, height: imageSize)

        leftBottomImageView.frame = CGRect(x: x - imageSize/2, y: y + h - imageSize/2, width: imageSize, height: imageSize)
        rightBottomImageView.frame = CGRect(x: x + w - imageSize/2, y: y + h - imageSize/2, width: imageSize, height: imageSize)

    }
    
    func removeImageViews(){
        leftTopImageView.removeFromSuperview()
        rightTopImageView.removeFromSuperview()
        leftBottomImageView.removeFromSuperview()
        rightBottomImageView.removeFromSuperview()
    }
    
    @objc
    func moveCorner(_ sender: UIPanGestureRecognizer){
        //设置起始值
        var startPoint: CGPoint?
        //获取当前点击view的范围
        var minX = superview!.frame.minX - imageSideLength
        var maxX = superview!.frame.maxX - imageSize + imageSideLength
        var minY = superview!.frame.minY - imageSideLength
        var maxY = superview!.frame.maxY - imageSize + imageSideLength
        
        //判断对应图像角标(计算原理根据当前点的最大XY轴方向)
        switch sender.view {
        case leftTopImageView:
            
            startPoint = startLeftTopPoint
            maxY = (leftBottomImageView.frame.minY)-imageSize-imageMinSpace
            maxX = (rightTopImageView.frame.minX)-imageSize-imageMinSpace
            
        case rightTopImageView:
            
            startPoint = startRightTopPoint
            maxY = (rightBottomImageView.frame.minY)-imageSize-imageMinSpace
            minX = (leftTopImageView.frame.maxX)+imageMinSpace
            
        case leftBottomImageView:
            
            startPoint = startLeftBottomPoint
            minY = (leftTopImageView.frame.maxY)+imageMinSpace
            maxX = (rightBottomImageView.frame.minX)-imageSize-imageMinSpace
            
        case rightBottomImageView:
            
            startPoint = startRightBottomPoint
            minY = (rightTopImageView.frame.maxY)+imageMinSpace
            minX = (leftBottomImageView.frame.maxX)+imageMinSpace
            
        default:
            break
        }
        
        switch sender.state {
            //手势状态->开始点击
        case .began:
            startPoint = sender.location(in: superview)
            superview?.isUserInteractionEnabled = false
            //手势状态->值变化
        case .changed:
            let endPoint = sender.location(in: superview)
            var rect = sender.view?.frame
            rect?.origin.x += (endPoint.x - (startPoint?.x ?? 0))
            rect?.origin.y += (endPoint.y - (startPoint?.y ?? 0))
            rect!.origin.x = min(maxX, max(rect!.origin.x, minX))
            rect!.origin.y = min(maxY, max(rect!.origin.y, minY))
            sender.view?.frame = rect!
            startPoint = endPoint
            //手势状态->点击停止
        case .ended:
            superview?.isUserInteractionEnabled = true
        default:
            break
        }
        
        //传递点击的手势所在view
        resetImageView(sender.view as? UIImageView)
        resetCropView()
    }
    
    func resetCropView(){
        frame = CGRect(x: leftTopImageView.frame.minX + imageSideLength,
                       y: leftTopImageView.frame.minY + imageSideLength,
                       width: rightTopImageView.frame.maxX - leftTopImageView.frame.minX - imageSideLength*2,
                       height: leftBottomImageView.frame.maxY - leftTopImageView.frame.minY - imageSideLength*2)
        
        print("x:\(frame.origin.x)\ny:\(frame.origin.y)\nw:\(frame.size.width)\nh:\(frame.size.height)")
    }
    
    func resetImageView(_ view: UIImageView?){
        switch view {
            
        case leftTopImageView:
            
            rightTopImageView.center = CGPoint(x: rightTopImageView.center.x, y: leftTopImageView.center.y)
            leftBottomImageView.center = CGPoint(x: leftTopImageView.center.x, y: leftBottomImageView.center.y)
            
        case rightTopImageView:
            
            leftTopImageView.center = CGPoint(x: leftTopImageView.center.x, y: rightTopImageView.center.y)
            rightBottomImageView.center = CGPoint(x: rightTopImageView.center.x, y: rightBottomImageView.center.y)
            
        case leftBottomImageView:
            
            leftTopImageView.center = CGPoint(x: leftBottomImageView.center.x, y: leftTopImageView.center.y)
            rightBottomImageView.center = CGPoint(x: rightBottomImageView.center.x, y: leftBottomImageView.center.y)

            
        case rightBottomImageView:
            
            rightTopImageView.center = CGPoint(x: rightBottomImageView.center.x, y: rightTopImageView.center.y)
            leftBottomImageView.center = CGPoint(x: leftBottomImageView.center.x, y: rightBottomImageView.center.y)
            
        default:
            break
        }
    }
    
    @objc
    func clickView(_ sender: UITapGestureRecognizer){
        if isShowImage{
            removeImageViews()
        }else{
            addImageViews()
        }
        isShowImage = !isShowImage
    }
    
    @objc
    func moveView(_ sender: UIPanGestureRecognizer){
        let minX = superview!.frame.minX
        let maxX = superview!.frame.maxX - frame.size.width
        let minY = superview!.frame.minY + 64
        let maxY = superview!.frame.maxY - frame.size.height
        
        switch sender.state {
        case .began:
            startMovePoint = sender.location(in: superview)
        case .changed:
            let endPoint = sender.location(in: superview)
            var rect = sender.view?.frame
            rect?.origin.x += (endPoint.x - (startMovePoint?.x ?? 0))
            rect?.origin.y += (endPoint.y - (startMovePoint?.y ?? 0))
            rect!.origin.x = min(maxX, max(rect!.origin.x, minX))
            rect!.origin.y = min(maxY, max(rect!.origin.y, minY))
            sender.view?.frame = rect!
            startMovePoint = endPoint
        case .ended:
            leftTopImageView.isUserInteractionEnabled = true
            rightTopImageView.isUserInteractionEnabled = true
            leftBottomImageView.isUserInteractionEnabled = true
            rightBottomImageView.isUserInteractionEnabled = true
        default:
            break
        }
        
        resetAllImageView()
    }
    
    func resetAllImageView(){
        leftTopImageView.center = CGPoint(x: frame.minX - imageSideLength + imageSize,
                                          y: frame.minY - imageSideLength + imageSize)

        rightTopImageView.center = CGPoint(x: frame.maxX + imageSideLength - imageSize,
                                           y: frame.minY - imageSideLength + imageSize)
        
        leftBottomImageView.center = CGPoint(x: frame.minX - imageSideLength + imageSize,
                                             y: frame.maxY + imageSideLength - imageSize)
        
        rightBottomImageView.center = CGPoint(x: frame.maxX + imageSideLength - imageSize,
                                              y: frame.maxY + imageSideLength - imageSize)
        
        layoutIfNeeded()
    }
}

class RectTextView: MoveView {
    
}
