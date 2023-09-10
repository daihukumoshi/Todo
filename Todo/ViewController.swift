//
//  ViewController.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/04.
//

import UIKit
import RealmSwift
class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    @IBOutlet var tableView: UITableView!
    var items: [TodoItem] = []
    var index: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
        items = readItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableView.reloadData()
    }
    
    func readItems() -> [TodoItem]{
        return Array(realm.objects(TodoItem.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoTableViewCell
        let item: TodoItem = items[indexPath.row]
        cell.setCell(title: item.title, category: item.category?.title ?? "")
                        
        return cell
    }
    
    //スライドアクション
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            //ボタン押下後の処理
            //let item: TodoItem = items[indexPath.row]
            let item = self.realm.objects(TodoItem.self).where({$0.title == self.items[indexPath.row].title})
            try! self.realm.write{
                self.realm.delete(item)
            }
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let editAction = UIContextualAction(style: .normal, title: "編集") { (action, view, completionHandler) in
            //ボタン押下後の処理
            self.index = indexPath.row
            self.performSegue(withIdentifier: "Edit", sender: nil)
        }
        
        editAction.backgroundColor = UIColor.green
        deleteAction.image = UIImage(systemName: "trash.fill")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
    //値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit"{
            let EditViewController = segue.destination as! EditViewController
            EditViewController.item = self.items[index]
        }
    }
    
}

