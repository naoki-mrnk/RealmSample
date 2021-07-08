//
//  AddItemViewController.swift
//  RealmSample
//
//  Created by naoki-mrnk on 2021/07/05.
//

import UIKit
import RealmSwift
import SwiftMoment


class AddItemViewController: UIViewController {
    // MARK: - Properties
    /// 前の画面に戻すTextを入れておく変数
    var backString = String()
    let realm = try! Realm()
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    @IBAction func addArray(_ sender: UIButton) {
        
        backString = textField.text!
        
        
        let newItem = Items()
        let moment = moment()
        let dateType = moment.date
        
        try! realm.write{
            newItem.itemName = backString
            newItem.createAt = dateType
        }
        
        do{
          try realm.write{
            realm.add(newItem)
          }
        }catch {
          print("Error \(error)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

