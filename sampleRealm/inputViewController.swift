//
//  inputViewController.swift
//  sampleRealm
//
//  Created by 井上勇斗 on 2019/05/02.
//  Copyright © 2019 井上勇斗. All rights reserved.
//

import UIKit
import RealmSwift

class inputViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    //この画面で追加または編集するTODO
    var todo: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let t = todo{
            textField.text = t.title
            button.setTitle("更新",for: .normal)
        }else{
            button.setTitle("追加",for: .normal)
        }
    }
    
    @IBAction func didClickBtn(_ sender: Any) {
        if let title = textField.text{
//            空文字の場合処理しない
            if title == ""{
//                returnを書くと処理がそこで終わる
                return
            }
            
            let realm = try! Realm()
            
            //更新か追加で分岐
            if let t = todo{
                try! realm.write{
                    t.title = title
                }
                //更新
            }else{
                //追加
                todo = Todo()
                todo?.title = title
                todo?.data = Data()
                
                let maxId = (realm.objects(Todo.self).max(ofProperty:"id")
                    as Int? ?? 0) + 1
                todo?.id = maxId
                try! realm.write{
                    realm.add(todo!)
                }
            }
            
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    
}
