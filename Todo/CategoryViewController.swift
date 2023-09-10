//
//  CategoryViewController.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/10.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    let realm = try! Realm()
    @IBOutlet var tableView: UITableView!
    var categories: [Category] = []
    var index: Int = 0
    var selectedCategory: Category? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        categories = readCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categories = readCategories()
        tableView.reloadData()
    }
    
    func readCategories() -> [Category]{
        return Array(realm.objects(Category.self))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let category: Category = categories[indexPath.row]
        cell?.textLabel?.text = category.title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedCategory = categories[indexPath.row]
        self.performSegue(withIdentifier: "EachCategory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EachCategory"{
            let categoryTodoViewController = segue.destination as! CategoryTodoViewController
            categoryTodoViewController.selectedCategory = self.selectedCategory
        }
        
        if segue.identifier == "CategoryEdit"{
            let EditCategoryViewController = segue.destination as! EditCategoryViewController
            EditCategoryViewController.category = self.categories[index]
        }
    }
    
    //スライドアクション
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            //ボタン押下後の処理
            //let item: TodoItem = items[indexPath.row]
            let item = self.realm.objects(Category.self).where({$0.title == self.categories[indexPath.row].title})
            try! self.realm.write{
                self.realm.delete(item)
            }
            self.categories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let editAction = UIContextualAction(style: .normal, title: "編集") { (action, view, completionHandler) in
            //ボタン押下後の処理
            self.index = indexPath.row
            self.performSegue(withIdentifier: "CategoryEdit", sender: nil)
        }
        
        editAction.backgroundColor = UIColor.green
        deleteAction.image = UIImage(systemName: "trash.fill")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
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
