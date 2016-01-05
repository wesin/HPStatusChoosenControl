//
//  CommonFunc.swift
//  WSStatusChooseControll
//
//  Created by 何文新 on 16/1/5.
//  Copyright © 2016年 wesin. All rights reserved.
//

import UIKit

class CommonFunc {
    
    static func getUIColorFromHexStr(hexStr:String) -> UIColor {
        let red = CGFloat(hex2dec(hexStr[0..<2]))
        let green = CGFloat(hex2dec(hexStr[2..<4]))
        let blue = CGFloat(hex2dec(hexStr.substringFromIndex(4)))
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    //十六进制转十进制
    static func hex2dec(num:String) -> Int {
        let str = num.uppercaseString
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
}

extension String {
    subscript(index:Int) -> Character{
        return self[self.startIndex.advancedBy(index)]
    }
    subscript(range:Range<Int>) -> String {
        let start = self.startIndex.advancedBy(range.startIndex)
        let end = self.startIndex.advancedBy(range.endIndex)
        return self[start..<end]
    }
    
    func substringFromIndex(index:Int) -> String {
        return self.substringFromIndex(self.startIndex.advancedBy(index))
    }
}

struct HPColor {
    /// 主题颜色蓝
    static let HPTitleColor = CommonFunc.getUIColorFromHexStr("18A0EE")
    /// 明细颜色
    static let remarkColor = CommonFunc.getUIColorFromHexStr("919191")
}
