//
//  ViewController.swift
//  dentakuApp
//
//  Created by アプリ開発 on 2020/07/25.
//  Copyright © 2020 Masato.achiwa. All rights reserved.
//

import UIKit
//9月8日aaaaaaaaaadfsdfasfas
class ViewController: UIViewController{
        
        enum  CalculateStatus{
                case none,plus,minas,kakezan,warizan
        }
        var culSymbol = ""
        var firstNumber = ""
        var secondNumber = ""
        var a : Double = 0
        var calculateStatus: CalculateStatus = .none
        var result = ""
        var aaa : String = ""
        var value1 : NSDecimalNumber  = 0
        var value2 : NSDecimalNumber = 0
        var value3 : NSDecimalNumber = 0
        var shoCount : Int  = 0
        var numberArray = [String]()
        var firstNumberrr = "0"
        var secondNumberrr = "0"
        var resultNumber = 0
        var last : String = ""
        
        //aaaa
        let numbers = [
                ["C","%","S","De"],
                ["7","8","9","+"],
                ["4","5","6","-"],
                ["1","2","3","×"],
                ["0",".","=","÷"],
        ]
        
        
        @IBOutlet var calculatiorCollectionView: UICollectionView!
        
        @IBOutlet var formulaHiddenLabele: UILabel!
        

        
        @IBOutlet var formulaLabel: UILabel!
        @IBOutlet var symbolLabel: UILabel!
        @IBOutlet var showLabel: UILabel!
        
        @IBOutlet var hiddenLabel: UILabel!
        
        @IBOutlet var caluculateHegihtConstraint: NSLayoutConstraint!
        
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
               // showLabel.isHidden = true
                
                calculatiorCollectionView.delegate = self
                calculatiorCollectionView.dataSource = self
                calculatiorCollectionView.register(CaluculatiorViewCell.self,forCellWithReuseIdentifier: "callId")
             //   caluculateHegihtConstraint.constant = view.frame.width * 1.4
                caluculateHegihtConstraint.constant = view.frame.height * 0.6
                calculatiorCollectionView.backgroundColor = .clear
                calculatiorCollectionView.contentInset = .init(top: 0,left: 14,bottom: 0, right: 14)
                
           showLabel.text = "0"
                             formulaLabel.text = "0"
                             symbolLabel.text = ""
                             hiddenLabel.text = ""
                self.shoCount = 0
        }
        
        
        
        func clear(){
                firstNumber = ""
                secondNumber = ""
                showLabel.text = ""
                calculateStatus = .none
                formulaLabel.text = "0"
                hiddenLabel.text = ""
                self.shoCount = 0
        }
        
        
}

class CaluculatiorViewCell: UICollectionViewCell{
        
        let numberLabel: UILabel = {
                let label = UILabel()
                label.textColor = .white
                label.text = "1"
                label.textAlignment = .center
                label.font = .boldSystemFont(ofSize: 32)
                label.backgroundColor = .black
                label.clipsToBounds = true  //有効で丸になる
                return label
        }()
        
        
        
        override init(frame: CGRect){
                super.init(frame: frame)
                
                addSubview(numberLabel)//ラベルの追加
                // backgroundColor = .black
                
                numberLabel.frame.size = self.frame.size   //セルの大きさと同じ大きさ
               
                
                numberLabel.layer.cornerRadius = self.frame.height / 9
        }
        
        required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
        }
        
        
        
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
                return numbers.count
        }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return numbers[section].count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "callId", for: indexPath) as! CaluculatiorViewCell  //表示するセルを登録(先程命名した"Cell")
                //cell.backgroundColor = .red
                cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
                numbers[indexPath.section][indexPath.row].forEach{(numberString) in  //numberStringは変数　forEacheそれぞれのという意味
                        if "0"..."9" ~= numberString || numberString.description == "."{
                                cell.numberLabel.backgroundColor = .black}
                }
                
                
                
                
                return cell
        }
        
        //ヘッダーの大きさ
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
                return .init(width: collectionView.frame.width, height: 10)
        }
        
        //cellの大きさ
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
                let width = ((collectionView.frame.width - 10) - 14 * 5) / 4
                let height = ((collectionView.frame.width - 10) - 14 * 5) / 5
                return .init(width: width, height: height)
                
                
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                
                return 14
        }
        
        //セルをタップした時のメソッド
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let number = numbers[indexPath.section][indexPath.row]  //ラベルの振り分け
                // print(number)
                
                
                guard let showNum = showLabel.text else{ //
                        return
                }
                let senderNum : String = number //タップされたセルの値の取得
                
                switch senderNum {
                        
                case "0"..."9": //０から９のセルをタップしたら
                       guard let nowFormula = formulaLabel.text else{
                                       return
                      
                       
                       }
                       
                     
                if symbolLabel.text != ""{      //プラス等があったら¥
                        showLabel.text = showNum + senderNum
                              //  symbolLabel.text = ""
                                showLabel.isHidden = false
                        guard let showNum = showLabel.text else{
                           return
                        }
                      guard let last = numberArray.last else{
                                                    return
                                            }
                            print(last)
                                            switch last {//配列の最後が記号だったら（３＋５）の５を入力した場合
                                           
                                             case "+","-","×","÷":
                                            numberArray.append(senderNum)
                                            print(numberArray)

                                            secondNumberrr = numberArray.last ?? "0"
                                            print("secondNumberrrは\(secondNumberrr)")
                                                
                                           arrayCulc()
                           
                                            default:           //配列の最後が数字だったら(数字をつづけて入力した場合）
                                            numberArray.removeLast()
                                            numberArray.append(showNum)
                                            
                                            secondNumberrr = numberArray.last ?? "0"
                                            
                                            arrayCulc()
                                            
                                            
                                            
                                            
                                            print("最後の数字は\(last)")
                                                    print(numberArray)
                                            print("secondNumberrrは\(secondNumberrr)")
                                                
                                              print("aaaaa")
                       
                                                
                        }
                        }else if showNum == "0"{ //ラベルが０だったら
                                showLabel.text = senderNum
                        self.shoCount = showNum.count
                         print("shoCount\(shoCount)")
                        showLabel.isHidden = false
                                        
                                        
                                        formulaLabel.text = senderNum
                        let hidden = showLabel.text
                        hiddenLabel.text = hidden
                        
                       numberArray.append(senderNum)
                        print(numberArray)
                        firstNumberrr = numberArray[0]
                        print("firstNumberrrdは\(firstNumberrr)")
                        
                                
                        }else {  //0じゃなくて数字が入力されたら
                                showLabel.text = showNum + senderNum
                                formulaLabel.text = showNum + senderNum
                  showLabel.isHidden = false
                        guard let last = numberArray.last else{
                                return
                        }
      print("最後の数字は\(last)")
                       
            
                        
                       numberArray.removeLast()
                       numberArray.append(showNum + senderNum)

                        print(numberArray)
                        firstNumberrr = numberArray[0]
                        print("firstNumberrrdは\(firstNumberrr)")
                               
                   
                        guard let showNum = showLabel.text else{ //
                            return
        
                        
                        }
                        
                        self.shoCount = showNum.count
                         print("shoCount\(shoCount)")
                        //let hidden = showLabel.text
                                      //        hiddenLabel.text = hidden
                        
               
                        
                       }
                       if nowFormula != "0"{
                       formulaLabel.text = nowFormula + number
                      
                }
                       
                       if nowFormula.contains("=") {

                       formulaLabel.text = senderNum
                        showLabel.text = senderNum
                        hiddenLabel.text = ""
                        
                        }
                               
                        
                        
                        
                        
                        
                        
                
                case "+","-","×","÷":
                        
                        
                        guard let last = numberArray.last else{
                                                       return
                        }
                        
                        
                        
                        showLabel.isHidden = false
                        showLabel.text = ""
                        let senderdCulc = number
                        
                        
                
                        
                        switch last {
                     
                        
                        case "+","-","×","÷":
                                numberArray.removeLast()
                                numberArray.append(senderdCulc)
                                print(numberArray)
                        
                                
                                
                        default:

                                        numberArray.append(senderdCulc)
                                        print("最後の数字は\(last)")
                                        print(numberArray)
                                
                        }
                        
                       formulaControl(send: senderdCulc) //記号を引数にしたメソッド

                        symbolLabel.text = number
                  
                        
                        
                case "C":
                        showLabel.text = "0"
                        formulaLabel.text = "0"
                        symbolLabel.text = ""
                        self.result = ""
                      //  hiddenLabel.text = self.result
                        formulaHiddenLabele.text = ""
                        value1 = 0
                        numberArray.removeAll()
                 
                case "De":

                   
                        
                                      guard let showNum = showLabel.text else{
                      return
                        }
                        guard let nowformula = formulaLabel.text else{
                        return
                          }
                                      self.shoCount = showNum.count

        print("shoCount\(shoCount)")
             
                      
                     
                if nowformula.hasSuffix("+")||nowformula.hasSuffix("-")||nowformula.hasSuffix("×")||nowformula.hasSuffix("÷"){
                   return
                     
                        
                }else{     if shoCount >= 1{
                                               let a =  showNum.dropLast()
                                               showLabel.text = String(a)
                                                                       
                                                       let b = nowformula.dropLast()
                                                       formulaLabel.text = String(b)
                                                       shoCount = shoCount - 1
                                                            print("ループ中")
                                                               }

                        }
                                      
              
                case "=":
        
                        guard let nowFormula1 = formulaLabel.text else{
                  return
          }
          if nowFormula1.contains("="){
                formulaLabel.text = aaa
                
          }else if nowFormula1.hasSuffix("+")||nowFormula1.hasSuffix("-")||nowFormula1.hasSuffix("×")||nowFormula1.hasSuffix("÷"){
                
               return
          }
          
          
         else  if nowFormula1.contains("+")||nowFormula1.contains("-")||nowFormula1.contains("×")||nowFormula1.contains("÷"){
                        

                symbolLabel.text = ""
           //    culc()
                guard let nowFormula = formulaLabel.text else{
                        return
                }
                formulaLabel.text = nowFormula + "=" + self.result
                self.aaa = formulaLabel.text ?? ""
               
             //   hiddenLabel.text = self.result
                        }
                        
                        
                        
                        
                default:
                        print("")
                        
                }

        }
                
                
                
                
        func formulaControl(send: String){
                   guard let nowFormula = formulaLabel.text else{
                                         return
                   }
          guard let showNum = showLabel.text else{
                                return
                        }
                
                guard let nowCulc = symbolLabel.text else{
                   return
           }
               
                switch nowCulc{
                        
                case "+","-","×","÷","=":
                formulaHiddenLabele.text = String(nowFormula[nowFormula.startIndex..<nowFormula.index(before:nowFormula.endIndex)]) + send
                        
                        //記号を押したら、formulaLabelのテキストの最初の文字から最後の文字まで(記号)から一文字戻してsendを追加
                        if nowFormula.hasSuffix("+"){
                     
                formulaLabel.text = String(nowFormula[nowFormula.startIndex..<nowFormula.index(before:nowFormula.endIndex)]) + send
                        }else if nowFormula.hasSuffix("-"){
                 formulaLabel.text = String(nowFormula[nowFormula.startIndex..<nowFormula.index(before:nowFormula.endIndex)]) + send
                                
                        }else if nowFormula.hasSuffix("×"){
                        formulaLabel.text = String(nowFormula[nowFormula.startIndex..<nowFormula.index(before:nowFormula.endIndex)]) + send
                                       
                               }else if nowFormula.hasSuffix("÷"){
                               formulaLabel.text = String(nowFormula[nowFormula.startIndex..<nowFormula.index(before:nowFormula.endIndex)]) + send
                                              
                                      }else if nowFormula.hasSuffix("="){
                                      formulaLabel.text = String(nowFormula[nowFormula.startIndex..<nowFormula.index(before:nowFormula.endIndex)]) + send
                                                     
                                             }
                    
                        else{
                                formulaLabel.text = nowFormula  + send
                        }
                default:
                        //culc()
                       
                        formulaLabel.text = nowFormula  + send
                        formulaHiddenLabele.text = nowFormula  + send
                        
                }

                
            }
//
// func culc(){
//
//             guard let nowFormula = formulaHiddenLabele.text else{
//                     return
//             }
//             guard let showNum = showLabel.text else{
//                     return
//             }
//             guard let showHidden = hiddenLabel.text else{
//                     return
//             }
//             guard let nowCulc = symbolLabel.text else{
//                               return
//                       }
//         print("nowFormula\(nowFormula) です")
//             print("showNumは\(showNum) です")
//         print("showHiddenは\(showHidden) です")
//
//             if showHidden == ""{
//                  let  showHidden = showNum
//            //    hiddenLabel.text = showHidden  //showラベルから隠れラベルの値を取得
//                 print("showHiddenは\(showHidden) です")
//             } else {
//
//                let culSymbol = nowFormula.suffix(1)  //文字列の末尾を取得
//
//
//                self.value1 = NSDecimalNumber(string: showHidden)
//                self.value2 = NSDecimalNumber(string: showNum)
//                print("value1は\(value1)")
//                print("value2は\(value2)")
//                print("culSymbol\(culSymbol)")
//                print("culSymbol\(nowCulc)")
//
//                     switch culSymbol{
//                     case "+": guard let showHidden = hiddenLabel.text else{
//                                                return
//                     }
//
//
//
//                             value1 = value1.adding(value2)//計算結果がvalue１に代入
//                             self.result = value1.stringValue
//                        showLabel.text = result
//
//             //           hiddenLabel.text = result
//                            // self.value1 = NSDecimalNumber(string: showHidden)
//                     self.value1 = self.value3
//
//                     case"-":
//
//                        value1 = value1.subtracting(value2)
//                        self.result = value1.stringValue
//                       showLabel.text = result
//
//                       hiddenLabel.text = result
//                     case "×":
//                            print(value1)
//                            print(value2)
//                        value1 = value1.multiplying(by : value2)
//                            self.result = value1.stringValue
//                        showLabel.text = result
//
//             //           hiddenLabel.text = result
//                     case"÷":
//                             if value2 == 0{
//                                viewDidLoad()
//                                showLabel.text = "Error"
//
//
//
//                        }else{
//
//                        value1 = value1.dividing(by:value2)
//                                self.result = value1.stringValue
//                                showLabel.text = result
//                  //              hiddenLabel.text = result
//
//                        }default:
//                             return
//
//                     }
//
//
//             }
     
    // }
//        func nweCulc(){
//
//                    guard let nowFormula = formulaHiddenLabele.text else{
//                            return
//                    }
//                    guard let showNum = showLabel.text else{
//                            return
//                    }
//                    guard let showHidden = hiddenLabel.text else{
//                            return
//                    }
//                    guard let nowCulc = symbolLabel.text else{
//                                      return
//                              }
//                print("nowFormula\(nowFormula) です")
//                    print("showNumは\(showNum) です")
//                print("showHiddenは\(showHidden) です")
//
//                    if showHidden == ""{
//                         let  showHidden = showNum
//                       self.value1 = NSDecimalNumber(string: showHidden)
//                        print("if文のvalue1は\(value1)")
//                                              print("value2は\(value2)")
//
//
//                    } else {
//
//                        self.value1 = NSDecimalNumber(string: showHidden)
//                        print("else文のvalue1は\(value1)")
//
//
//
//
//                       let culSymbol =  nowCulc //文字列の末尾を取得
//
//
//
//                       self.value2 = NSDecimalNumber(string: showNum)
//
//                       print("value2は\(value2)")
//
//                       print("culSymbol\(culSymbol)")
//                       print("culSymbol\(nowCulc)")
//
//                            switch culSymbol{
//                            case "+":
//                                self.value3 = value1.adding(value2)//計算結果がvalue１に代入
//                                    print("いいいvalue1は\(value1)")
//
//                                self.result = value3.stringValue
//                              print("ressult\(result)")
//                                print("あああvalue1は\(value1)")
//                                 print("value3は\(value3)")
//
//              //                 hiddenLabel.text = result
//
//                            case"-":
//
//                               value1 = value1.subtracting(value2)
//                               self.result = value1.stringValue
//
//
//                  //            hiddenLabel.text = result
//                            case "×":
//                                   print(value1)
//                                   print(value2)
//                               value1 = value1.multiplying(by : value2)
//                                   self.result = value1.stringValue
//
//
//                               hiddenLabel.text = result
//                            case"÷":
//                                    if value2 == 0{
//                                       viewDidLoad()
//                                       showLabel.text = "Error"
//
//
//
//                               }else{
//
//                               value1 = value1.dividing(by:value2)
//                                       self.result = value1.stringValue
//                                       showLabel.text = result
//                   //                    hiddenLabel.text = result
//
//                               }default:
//                                    return
//
//                            }
//
//
//                    }
//
//
//
//
//
//
//
//            }
        
        func arrayCulc(){
                guard let symbol = symbolLabel.text else{
                return
                }
                
                var arrayCount = numberArray.count
                if arrayCount >= 3 && arrayCount < 5{
                        print("firstNumberrrとsecondNumbeerは\(firstNumberrr)と\(secondNumberrr)")
                       
                        switch  symbol {
                        case "+":
                                let aNumber :Int = Int(firstNumberrr) ?? 0
                                let bNumber : Int = Int(secondNumberrr) ?? 0
                                self.resultNumber =  aNumber + bNumber
                                
                                print("resultNumberは\(self.resultNumber)")
                               hiddenLabel.text = String(self.resultNumber)
                                
                        default:
                                print("デフォルト")
                        }
                        
                }
                
                if arrayCount >= 5{
                        print("firstNumberrrとsecondNumbeerは\(firstNumberrr)と\(secondNumberrr)")
                       let aNumber = hiddenLabel.text
                        print("aNumberとsecondNumbeerは\(aNumber)と\(secondNumberrr)")
                        
                        switch  symbol {
                        case "+":
                                let aNumber : Int = Int(hiddenLabel.text ?? "0") ?? 0
                                let bNumber : Int = Int(secondNumberrr) ?? 0
                                self.resultNumber = aNumber + bNumber
                                
                                print("resultNumberは\(self.resultNumber)")
                                hiddenLabel.text = String(self.resultNumber)
                                
                        default:
                                print("デフォルト")
                        }
                        
                }
                
                
                
                
                
                
                
                
                
                
                
                
        }
        
        
        
}


















        



