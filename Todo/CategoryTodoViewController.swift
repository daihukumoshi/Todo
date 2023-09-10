//
//  CategoryTodoViewController.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/10.
//

import UIKit
import RealmSwift

class CategoryTodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let realm = try! Realm()
    @IBOutlet var tableView: UITableView!
    var items: [TodoItem] = []
    var index: Int = 0
    var selectedCategory: Category!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        items = readItems()
        navigationItem.title = selectedCategory.title

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableView.reloadData()
    }
    func readItems() -> [TodoItem]{
        return Array(realm.objects(TodoItem.self).filter("category == %@", selectedCategory!))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTodo"{
            let addViewController = segue.destination as! AddViewController
            addViewController.category = self.selectedCategory
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let item: TodoItem = items[indexPath.row]
        cell?.textLabel?.text = item.title
        
        return cell!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
