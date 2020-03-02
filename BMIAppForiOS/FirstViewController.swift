import UIKit

class FirstViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var inputTitle: UINavigationBar!
    @IBOutlet weak var tutorialText: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var cmLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var kgLabel: UILabel!
    @IBOutlet weak var bmiCalcButton: UIButton!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var bmiLeftLabel: UILabel!
    @IBOutlet weak var bmiResultLabel: UILabel!
    @IBOutlet weak var bmiRightLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    // なんでも良いから初期値として設定しておく。
    var testText:String = ConstClass.DEFAULT_VALUE
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    // 今日の日付
    var today:String = ""
    // 日付保存配列
    var allDayList:[String] = []
    // 身長
    var strHeight = ""
    // 体重
    var strWeight = ""
    // BMI
    var strBmi = ""
    
    private struct Const {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 今日の日付を取得する
        getToday()
        // 画面に数値が表示されている場合は、空白に戻す
        initIndicate()
        // userdefaultから日付データを取得
        // リストの中身は1月→12月に並べたいので、「$0.0 < $1.0」としている
        for (key, _) in UserDefaults.standard.dictionaryRepresentation().sorted(by: { $0.0 < $1.0 }) {
            if(key.contains(ConstClass.FILTER_YEAR)){
                allDayList.append(key)
            }
        }
        var sameDayData:Bool = isSameDayData()
        var sameMonthData:Bool = isSameMonthData()
        // bmi計算ボタン押下処理
        bmiCalcButton.addTarget(self, action: #selector(bmiButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        // 削除ボタン押下処理
        deleteButton.addTarget(self, action: #selector(deleteButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        // 保存ボタン押下処理
        saveButton.addTarget(self, action: #selector(saveButtonEvent(_:)), for: UIControl.Event.touchUpInside)
    }
    
    /// bmi計算ボタン押下処理メソッド
    @objc func bmiButtonEvent(_ sender: UIButton){
        //バリデーションチェック
        if((heightTextField.text?.isEmpty ?? true)){
            dialog(errorMessage : ConstClass.ERROR_MESSAGE)
            return
        }
        if((weightTextField.text?.isEmpty ?? true)){
            dialog(errorMessage: ConstClass.ERROR_MESSAGE)
            return
        }
        strHeight = heightTextField.text!
        strWeight = weightTextField.text!
        strBmi = String(calcBmi(height: strHeight, weight: strWeight))
        bmiResultLabel.text = strBmi
    }
    /// 削除ボタン押下処理メソッド
    @objc func deleteButtonEvent(_ sender: UIButton){
        UserDefaults.standard.removeObject(forKey: today)
        initIndicate()
    }
    /// 保存計算ボタン押下処理メソッド
    @objc func saveButtonEvent(_ sender: UIButton){
        if((bmiResultLabel.text?.isEmpty ?? true)){
            dialog(errorMessage: ConstClass.ERROR_MESSAGE)
            return
        }
        var message:String = ConstClass.DEFAULT_VALUE
        if(!(messageTextView.text?.isEmpty ?? true)){
            message = messageTextView.text
        }
        // key
        let items:[String] = [ConstClass.HEIGHT, ConstClass.WEIGHT, ConstClass.BMI,ConstClass.MESSAGE,ConstClass.FLAG_SAME_DAY]
        // value
        let data:[String] = [strHeight,strWeight,strBmi,message,"true"]
        let ziped = zip(items, data)
        let saveData = Dictionary(uniqueKeysWithValues: ziped)
        userDefaults.set(saveData, forKey: today)
    }
    /// ダイアログ表示メソッド
    func dialog(errorMessage:String){
        let dialog = UIAlertController(title: ConstClass.DIALOG_TITLE_ERROR, message: errorMessage, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: ConstClass.DIALOG_OK_BUTTON, style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    /// 入力値の適正判定メソッド
    func checkInputValue(){
        
    }
    ///BMIを計算するメソッド
    func calcBmi(height:String,weight:String)->String{
        //整形する
        let num = Float(height)!/100
        let num1 = Float(weight)
        let floHeight = round(num*10)/10
        let floWeight = round(num1!*10)/10
        let bmi:Float = floWeight/(floHeight*floHeight)
        let numRound2 = String(round(bmi*10)/10)
        return numRound2
    }
    /// 同日のデータが存在するかチェックするメソッド
    func isSameDayData()->Bool{
        var bool = false
        if(allDayList.contains(today)){
            bool = true
        }
        return bool
    }
    /// 同月のデータが存在するかチェックするメソッド
    func isSameMonthData()->Bool{
        var bool = false
        let text3 = today[..<today.index(today.startIndex, offsetBy: 7)]
        //        var ccc=allDayList.contains(String(text3))
        //        print("ccc")
        //        print(ccc)
        //        print(allDayList)
        if(allDayList.contains(String(text3))){
            //            print("2月のデータがあります！")
            bool = true
        }
        //        print("2月のデータがありません！")
        return bool
    }
    /// 同日の日付を取得するメソッド
    func getToday(){
        let dt = Date()
        let dateFormatter = DateFormatter()
        // テスト用
        //        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: dt)!
        // 日付は"2020年1月01日"の形に整形する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: ConstClass.FORMAT_PATTERN, options: 0, locale: Locale(identifier: "ja_JP"))
        today = dateFormatter.string(from: dt)
        print(today)
    }
    /// 画面表示を初期化するメソッド
    func initIndicate(){
        tutorialText.text = ConstClass.ERROR_MESSAGE
        tutorialText.textAlignment = NSTextAlignment.center
        heightLabel.text = ConstClass.HEIGHT
        cmLabel.text = ConstClass.CM
        weightLabel.text = ConstClass.WEIGHT
        kgLabel.text = ConstClass.KG
        bmiLeftLabel.text = ConstClass.BMI_LEFT_TEXT
        bmiResultLabel.text = ""
        bmiRightLabel.text = ConstClass.BMI_RIGHT_TEXT
        messageTextView.text = ""
        // text fieldに枠線をつける
        // 枠のカラー
        messageTextView.layer.borderColor = UIColor.gray.cgColor
        // 枠の幅
        messageTextView.layer.borderWidth = 1.0
        // 枠を角丸にする
        messageTextView.layer.cornerRadius = 10.0
        messageTextView.layer.masksToBounds = true
        bmiCalcButton.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0, alpha: 0.4)
        lineLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
}
