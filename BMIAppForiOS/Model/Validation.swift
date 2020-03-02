//
//  Validation.swift
//  BMIAppForiOS
//
//  Created by Apple on 2020/02/26.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

/// バリデーションクラス
class Validation {
    /// true:入力値エラーなし、false:入力値エラーあり
    /// 入力値がnilまたはカラならfalseを返す
    static func isSuccess(value:String) -> Bool {
        if Double(value) == nil {
            return false
        }
        if value.isEmpty {
            return false
        }
        return true
    }
}
