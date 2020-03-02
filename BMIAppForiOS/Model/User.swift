//
//  User.swift
//  BMIAppForiOS
//
//  Created by Apple on 2020/02/26.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

/// ユーザーオブジェクトクラス
class User {
    let height: Height
    let weight: Weight
    let bmi: Bmi
    let message: Message
    init(height: Height, weight:Weight, bmi:Bmi, message:Message){
        self.height = height
        self.weight = weight
        self.bmi = bmi
        self.message = message
    }
}
