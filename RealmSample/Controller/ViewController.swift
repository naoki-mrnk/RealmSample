//
//  ViewController.swift
//  RealmSample
//
//  Created by naoki-mrnk 2021/07/05.
//

import UIKit
import SwiftMoment
import RealmSwift

class ViewController: UIViewController {
    
    // MARK: - Property
    var shoppingItems: Results<Items>!
    let realm = try! Realm()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var fab: UIButton!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupButton()
        
        
        shoppingItems = realm.objects(Items.self)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWill")
        tableView.reloadData()
    }
    
    // MARK: - IBAction
    @IBAction func toAddItemView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toAddItem", sender: self)
    }
    
    // FAB
    var startingFrame: CGRect!
    var endingFrame: CGRect!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) && self.fab.isHidden {
            self.fab.isHidden = false
            self.fab.frame = startingFrame
            UIView.animate(withDuration: 1.0) {
                self.fab.frame = self.endingFrame
            }
        }
    }
    
    func setupButton() {
        fab.layer.cornerRadius = 25
    }
    
    func configureSizes() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        startingFrame = CGRect(x: 0, y: screenHeight + 100, width: screenWidth, height: 100)
        endingFrame = CGRect(x: 0, y: screenHeight - 100, width: screenWidth, height: 100)
        
    }
    
    func deleteTodo(at index: Int) {
        try! realm.write {
            realm.delete(shoppingItems[index])
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let object = shoppingItems[indexPath.row]
        cell.textLabel!.text = object.itemName
        let nowDate = object.createAt
        cell.detailTextLabel?.text = "追加日: \(nowDate)"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            deleteTodo(at:indexPath.row)
            tableView.reloadData()
        }
    }
}
