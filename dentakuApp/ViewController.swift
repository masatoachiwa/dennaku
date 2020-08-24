//
//  ViewController.swift
//  dentakuApp
//
//  Created by アプリ開発 on 2020/07/25.
//  Copyright © 2020 Masato.achiwa. All rights reserved.
//

import UIKit

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
        var value1 : NSDecimalNumber  = 1.0
        var value2 : NSDecimalNumber = 1.0

        
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
                
        }
        
        
        
        func clear(){
                firstNumber = ""
                secondNumber = ""
                showLabel.text = ""
                calculateStatus = .none
                formulaLabel.text = "0"
                hiddenLabel.text = ""
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
                       
                     
                if symbolLabel.text != ""{      //プラス等があったら
                                showLabel.text = senderNum
                                symbolLabel.text = ""
                                
                                
                        }else if showNum == "0"{ //ラベルが０だったら
                                showLabel.text = senderNum
                            
                                        
                                        
                                        
                                        formulaLabel.text = senderNum
                                
                        }else {  //0じゃなくて数字が入力されたら
                                showLabel.text = showNum + senderNum
                                formulaLabel.text = showNum + senderNum
                    
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
                       guard let nowFormula = formulaLabel.text else{
                                                               return
                                         }
                       guard let showNum = showLabel.text else{
                               return
                       }
                       
                       
                    if nowFormula.contains("=") {

                    formulaLabel.text = showNum
//                     showLabel.text = senderNum
//                     hiddenLabel.text = ""
                     
                       
                       }
                       
                       
                       
                       
                       
                let senderdCulc = number
                
                       formulaControl(send: senderdCulc) //記号を引数にしたメソッド
                       let hidden = showLabel.text
                       hiddenLabel.text = hidden
                        symbolLabel.text = number
                  
                        
                        
                case "C":
                        showLabel.text = ""
                        formulaLabel.text = "0"
                        symbolLabel.text = ""
                        self.result = ""
                        hiddenLabel.text = self.result
                        formulaHiddenLabele.text = ""
                case "De":

                        print("D")
                        
//                                       guard let showNum = showLabel.text else{
//                      return
//                        }
//
//                let a =  showNum.dropLast()
//                  showLabel.text = String(a)
                        
                        
                
                
                
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
                        

                symbolLabel.text = number
               culc()
                guard let nowFormula = formulaLabel.text else{
                        return
                }
                formulaLabel.text = nowFormula + "=" + self.result
                self.aaa = formulaLabel.text ?? ""
               
                hiddenLabel.text = self.result
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
                        culc()
                        formulaLabel.text = nowFormula  + send
                        formulaHiddenLabele.text = nowFormula  + send
                        
                }

                
            }
        
 func culc(){
             
             guard let nowFormula = formulaHiddenLabele.text else{
                     return
             }
             guard let showNum = showLabel.text else{
                     return
             }
             guard let showHidden = hiddenLabel.text else{
                     return
             }
             guard let nowCulc = symbolLabel.text else{
                               return
                       }
         print("nowFormula\(nowFormula) です")
             print("showNumは\(showNum) です")
         print("showHiddenは\(showHidden) です")
             
             if showHidden == ""{
                  let  showHidden = showNum
                hiddenLabel.text = showHidden  //showラベルから隠れラベルの値を取得
                 print("showHiddenは\(showHidden) です")
             } else {
           
                let culSymbol = nowFormula.suffix(1)  //文字列の末尾を取得
                     
                     
                self.value1 = NSDecimalNumber(string: showHidden)
                self.value2 = NSDecimalNumber(string: showNum)
                print("value1は\(value1)")
                print("value2は\(value2)")
                print("culSymbol\(culSymbol)")
                print("culSymbol\(nowCulc)")
                     
                     switch culSymbol{
                     case "+":
                             value1 = value1.adding(value2)//計算結果がvalue１に代入
                             self.result = value1.stringValue
                        showLabel.text = result
                             
                        hiddenLabel.text = result
                        
                     case"-":
                      
                        value1 = value1.subtracting(value2)
                        self.result = value1.stringValue
                       showLabel.text = result
                   
                       hiddenLabel.text = result
                     case "×":
                            print(value1)
                            print(value2)
                        value1 = value1.multiplying(by : value2)
                            self.result = value1.stringValue
                        showLabel.text = result
                           
                        hiddenLabel.text = result
                     case"÷":
                             if value2 == 0{
                                viewDidLoad()
                                showLabel.text = "Error"
                               
                        
                                                        
                        }else{
                        
                        value1 = value1.dividing(by:value2)
                                self.result = value1.stringValue
                                showLabel.text = result
                                hiddenLabel.text = result
                     
                        }default:
                             return
                             
                     }
                
                     
             }
     
     }
}
        



