import UIKit
/// 履歴画面クラス
class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var recordTitle: UINavigationBar!
    @IBOutlet weak var recordTableView: UITableView!
    //UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    /// user defaultの中からkeyだけを集めて格納した配列
    var allKeyList:[String]=[]
    /// 月ごとのセクション表示用の配列
    var monthSections = [String]()
    var twoDimArray = [[String]]()
    /// その履歴が所属する月の用の変数
    var onMonth = ""
    /// 履歴用の変数
    var itemKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var uniqueValues = [String]()
        /// userdefaultの中から、2020年のデータを1月→12月の順番でリストに格納する
        for (key, _) in UserDefaults.standard.dictionaryRepresentation().sorted(by: { $0.0 < $1.0 }) {
            if(key.contains(ConstClass.FILTER_YEAR)){
                allKeyList.append(key)
            }
        }
        /// keyListの中の日付を、月まで(yyyy年mm月)の形に整形する
        for key in allKeyList {
            let formatedDate = key[..<key.index(key.startIndex, offsetBy: 7)]
            uniqueValues.append(String(formatedDate))
        }
        /// uniqueValuesリストの中から、重複を削除する
        let orderedSet = NSOrderedSet(array: uniqueValues)
        monthSections = orderedSet.array as! [String]
        /// 月ごとに履歴を格納する
        let sectionCount = monthSections.count - 1
        for _ in 0 ... sectionCount {
            twoDimArray.append([])
        }
        /// TODO : 修正が必要
        for key in allKeyList {
            if(key.contains(monthSections[0])){
                twoDimArray[0] = [key]
            }
            if(key.contains(monthSections[1])){
                twoDimArray[1] = [key]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return monthSections.count
    }
    
    // セクションの高さ
    func tableView(_ table:UITableView,heightForHeaderInSection  section:Int) -> CGFloat {
        return  30
    }
    
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return allKeyList.count
        return twoDimArray[section].count
    }
    // セルの高さ
    func tableView(_ table: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  80
    }
    
    // セクション
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return monthSections[section]
    }
    
    // セルを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCellId") as! CustomCell
//        cell.dayLabel!.text = twoDimArray[indexPath.section][indexPath.row]
//        var key = twoDimArray[indexPath.section][indexPath.row]
        // user defaultから対象の日付のデータを取得する
        for (key, _) in UserDefaults.standard.dictionaryRepresentation().sorted(by: { $0.0 > $1.0 }) {
//            if(key == allKeyList[indexPath.row]){
             if(key == twoDimArray[indexPath.section][indexPath.row]){
                var dictionary = UserDefaults.standard.dictionary(forKey: key)
                // セルに表示する値（ラベルの文字など）を設定する
                let day = dateFormatForDay(date:key)
                let height = dictionary![ConstClass.HEIGHT,default:ConstClass.DEFAULT_VALUE] as! String
                let weight = dictionary![ConstClass.WEIGHT,default:ConstClass.DEFAULT_VALUE] as! String
                let bmi = dictionary![ConstClass.BMI,default:ConstClass.DEFAULT_VALUE] as! String
                let message = dictionary![ConstClass.MESSAGE,default:ConstClass.DEFAULT_VALUE] as! String
                cell.dayLabel!.text = day
                cell.heightLabel!.text = ConstClass.HEIGHT_COLON + height + ConstClass.CM
                cell.weightLabel!.text = ConstClass.WEIGHT_COLON + weight + ConstClass.KG
                cell.bmiLabel!.text = ConstClass.BMI_COLON + bmi
                cell.messageLabel!.text = message
                // メッセージがない場合は、メッセージラベルを非表示にする
                if(message == ConstClass.DEFAULT_VALUE){
                    cell.messageLabel!.isHidden = true
                }
            }
        }
        return cell
    }
    // 日付を整形するメソッド(2020年2月5日→5日)
    func dateFormatForDay(date:String)->String{
        // 末尾から3文字だけ取得する
        var formatedDate = date.suffix(3)
        // もし文字列が"03日"の場合は"3日"に修正する
        if(formatedDate.contains("0")){
            formatedDate = date.suffix(2)
        }
        return String(formatedDate)
    }
    // 日付を整形するメソッド(2020年2月5日→2月)
    func dateFormatForMonth(date:String)->String{
        // 6文字目から7文字目までを取得する
        var from = date.index(date.startIndex, offsetBy: 4)
        var to = date.index(from, offsetBy: 2)
        var formatedMonth = date[from...to]
        // もし文字列が"年2月"の場合は"2月"に修正する
        if(formatedMonth.contains("年")){
            from = date.index(date.startIndex, offsetBy: 5)
            to = date.index(from, offsetBy: 1)
            formatedMonth = date[from...to]
        }
        return String(formatedMonth)
    }
}
