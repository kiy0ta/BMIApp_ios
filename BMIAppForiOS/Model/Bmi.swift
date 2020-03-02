//
//  Bmi.swift
//  BMIAppForiOS
//
//  Created by Apple on 2020/02/26.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

/// BMIオブジェクトクラス
class Bmi {
    let value:Double
    init(height:Height,weight:Weight){
        self.value = Bmi.calcBmi(height: height , weight: weight)
    }
    /// bmi計算メソッド
    static func calcBmi(height:Height,weight:Weight) -> Double{
        let resultValue = weight.value / pow(Format.convertToMeters(from: height.value), 2.0)
        return resultValue
    }
}
