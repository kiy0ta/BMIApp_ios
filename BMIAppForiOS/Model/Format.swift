//
//  Format.swift
//  BMIAppForiOS
//
//  Created by Apple on 2020/02/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
/// フォーマットクラス
class Format {
    /// 入力されたStringの値を、Double型(小数点第一位)に変更して、値を返すメソッド
    static func oneDecimalPlace(value: String) -> Double{
        /// 入力値がnilだったら0を返す
        guard let doubleValue = Double(value) else {
            return Double(0)
        }
        /// 入力値を週数点第一位のかたちにフォーマットする
        let formatedValue = String(format: "%.1f",doubleValue)
        /// フォーマットするためにstring型にしてしまったので、bmiの計算メソッドで値を使うためにDoubleに戻す必要がある
        /// フォーマットしたString値をNNStringでDoubleに変換する
        let resultValue = NSString(string: formatedValue).doubleValue
        return resultValue
    }
    /// 100cmを1mに変換するメソッド
    static func convertToMeters(from centimeters: Double) -> Double {
        let convertedValue = centimeters / 100
        return convertedValue
    }
}
