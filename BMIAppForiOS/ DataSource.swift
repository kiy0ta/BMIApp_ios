//
//   DataSource.swift
//  BMIAppForiOS
//
//  Created by Apple on 2020/02/04.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
final class DataSource: NSObject {
    private var items: [String] = ["茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県"]
}
//
//extension DataSource: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = items[indexPath.row]
//        return cell
//    }
//}
