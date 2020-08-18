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
        
        var firstNumber = ""
        var secondNumber = ""
        var a : Double = 0
        var calculateStatus: CalculateStatus = .none
        
        let numbers = [
                ["C","%","S","+"],
                ["7","8","9","-"],
                ["4","5","6","×"],
                ["1","2","3","÷"],
                ["0",".","=",],
        ]
        
        
        @IBOutlet var calculatiorCollectionView: UICollectionView!
        
      
        @IBOutlet var formulaLabel: UILabel!
        @IBOutlet var symbolLabel: UILabel!
        @IBOutlet var showLabel: UILabel!
        
        
        @IBOutlet var caluculateHegihtConstraint: NSLayoutConstraint!
        
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
                calculatiorCollectionView.delegate = self
                calculatiorCollectionView.dataSource = self
                calculatiorCollectionView.register(CaluculatiorViewCell.self,forCellWithReuseIdentifier: "callId")
             //   caluculateHegihtConstraint.constant = view.frame.width * 1.4
                caluculateHegihtConstraint.constant = view.frame.width * 1.2
                calculatiorCollectionView.backgroundColor = .clear
                calculatiorCollectionView.contentInset = .init(top: 0,left: 14,bottom: 0, right: 14)
                
                view.backgroundColor = .black
                
        }
        
        
        
        func clear(){
                firstNumber = ""
                secondNumber = ""
                showLabel.text = "0"
                calculateStatus = .none
                formulaLabel.text = ""
                
        }
        
        
}

class CaluculatiorViewCell: UICollectionViewCell{
        
        let numberLabel: UILabel = {
                let label = UILabel()
                label.textColor = .white
                label.text = "1"
                label.textAlignment = .center
                label.font = .boldSystemFont(ofSize: 32)
                label.backgroundColor = .orange
                label.clipsToBounds = true  //有効で丸になる
                return label
        }()
        
        
        
        override init(frame: CGRect){
                super.init(frame: frame)
                
                addSubview(numberLabel)//ラベルの追加
                // backgroundColor = .black
                
                numberLabel.frame.size = self.frame.size   //セルの大きさと同じ大きさ
                numberLabel.layer.cornerRadius = self.frame.height / 2
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
                                cell.numberLabel.backgroundColor = .darkGray}
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
                
                return .init(width: width, height: width)
                
                
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
                        if symbolLabel.text != ""{      //プラス等があったら
                                showLabel.text = senderNum
                                symbolLabel.text = ""
                        }else if showNum == "0"{ //ラベルが０だったら
                                showLabel.text = senderNum
                                
                        }else {  //0じゃなくて数字が入力されたら
                                showLabel.text = showNum + senderNum
                                
                        }
                case "+","-","×","÷":
                       
                    
                let senderdCulc = number
                       formulaControl(send: senderdCulc) //記号を引数にしたメソッド
                        
                        symbolLabel.text = number
                        
                case "C":
                        showLabel.text = "0"
                        formulaLabel.text = ""
                        symbolLabel.text = ""
                       
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
                        
                case "+","-","×","÷":   //記号を押したら、formulaLabelのテキストの最初の文字から、最後の文字(記号)から一文字戻してsendを追加
                        formulaLabel.text = String(nowFormula[nowFormula.startIndex..<nowFormula.index(before:nowFormula.endIndex)]) + send
                        
                default:
                       // culc()
                        formulaLabel.text = nowFormula + showNum + send
                        
                        
                }

                
            }
        
 
}
        



