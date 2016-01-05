//
//  HPStatusChoosenControl.swift
//  HupunErp
//
//  Created by 何文新 on 15/12/21.
//  Copyright © 2015年 Hupun. All rights reserved.
//

import UIKit

protocol HPStatusChoosenDelegate:class {
    func statusSelected(status:Int)
}

class HPStatusChoosenControl: UIView {

    /// 每行数量
    var numInRow = 4
    /// 数据源
    var dataSource:[(Int,String)]?
    /// 是否处于拉伸状态
    var stretch = false
    
    weak var delegate:HPStatusChoosenDelegate?
    
    private var backView = UIView()
    private var stretchView:UIView?
    private var itemArray = [UILabel]()
    private var stretchArray = [UILabel]()
    private var labelWidth :CGFloat = 0
    private var stretchHeight:CGFloat = 0
    private var labelSize : CGSize?
    private var downImageView:UIImageView?
    
    init(data:[(Int,String)]) {
        super.init(frame: CGRectZero)
        dataSource = data
        backView.backgroundColor = UIColor.whiteColor()
        self.addSubview(backView)
        var showNum = numInRow
        if data.count <= numInRow {
            showNum = data.count ?? 0
        } else {
            downImageView = UIImageView(image: UIImage(named: "arrowdown"))
            let imageClick = UITapGestureRecognizer(target: self, action: Selector("imageClick"))
            downImageView?.userInteractionEnabled = true
            downImageView?.addGestureRecognizer(imageClick)
            backView.addSubview(downImageView!)
        }
        
        for i in 0..<showNum {
            let label = UILabel()
            label.text = data[i].1
            label.tag = data[i].0
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(15)
            label.textColor = i == 0 ? HPColor.HPTitleColor : HPColor.remarkColor
            backView.addSubview(label)
            let tmpGesture = UITapGestureRecognizer(target: self, action: Selector("labelClick:"))
            label.userInteractionEnabled = true
            label.addGestureRecognizer(tmpGesture)
            itemArray.append(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if itemArray.count > 0 {
            backView.frame = self.bounds
            labelWidth = (self.bounds.width - 74) / 4
            labelSize = CGSize(width: labelWidth, height: 44)
            for i in 0..<itemArray.count {
                itemArray[i].frame = CGRect(origin: CGPoint(x: 15 + CGFloat(i) * labelWidth, y: 0), size: labelSize!)
            }
        }
        downImageView?.frame = CGRect(x: self.bounds.width - 59, y: 0, width: 44, height: 44)
    }
    
    func labelClick(sender:UITapGestureRecognizer) {
        let label = sender.view as! UILabel
        print(label.tag)
        _ = itemArray.map({
            $0.textColor = HPColor.remarkColor
        })
        _ = stretchArray.map({
            $0.textColor = HPColor.remarkColor
        })
        label.textColor = HPColor.HPTitleColor
        delegate?.statusSelected(label.tag)
    }
    
    func imageClick() {
        if stretch {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.stretchView?.frame.origin.y = 44 - self.stretchHeight
                self.layoutIfNeeded()
                }, completion: {
                    (Bool) in
                    self.downImageView?.image = UIImage(named:"arrowdown")
                    self.stretch = false
            })
        } else {
            if stretchView == nil {
                stretchView = UIView()
                stretchHeight = CGFloat((ceil(Double(dataSource!.count) / Double(numInRow))  - 1) * 44)
                stretchView?.frame = CGRect(x: 0, y: 44 - stretchHeight, width: self.bounds.width, height: stretchHeight)
                stretchView?.backgroundColor = UIColor.whiteColor()
                for i in numInRow..<dataSource!.count {
                    let label = UILabel()
                    label.text = dataSource![i].1
                    label.tag = dataSource![i].0
                    label.textAlignment = .Center
                    label.font = UIFont.systemFontOfSize(15)
                    label.textColor = HPColor.remarkColor
                    label.frame = CGRect(origin: CGPoint(x: 15 + CGFloat(i % numInRow) * labelWidth, y: CGFloat(((i - numInRow) / numInRow) * 44)), size: labelSize!)
                    stretchView?.addSubview(label)
                    let tmpGesture = UITapGestureRecognizer(target: self, action: Selector("labelClick:"))
                    label.userInteractionEnabled = true
                    label.addGestureRecognizer(tmpGesture)
                    stretchArray.append(label)
                }
                self.insertSubview(stretchView!, belowSubview: backView)
            }
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.stretchView?.frame.origin.y = 44
                self.layoutIfNeeded()
                }, completion: {
                    (Bool) in
                    self.downImageView?.image = UIImage(named:"arrowup")
                    self.stretch = true
            })
        }
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if point.y <= 44 {
            return getClickView(backView, point: point, event: event)
        } else if stretch {
            return getClickView(stretchView!, point: point, event: event)
        }
        return nil
    }
    
    private func getClickView(pView:UIView, point:CGPoint, event:UIEvent?) -> UIView? {
        for member in pView.subviews{
            let subPoint = member.convertPoint(point, fromView: self)
            let result = member.hitTest(subPoint, withEvent: event)
            if(result != nil){
                return result
            }
        }
        return nil
    }
}
