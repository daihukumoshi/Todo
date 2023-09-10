//
//  AddViewController.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/04.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    let realm = try! Realm()
    @IBOutlet var titleTextField: UITextField!
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func add(){
        let item = TodoItem()
        item.title = titleTextField.text  ?? ""
        item.category = category
        createItem(item: item)
        
        navigationController?.popViewController(animated: true)
    }
    
    func createItem(item: TodoItem) {
        try! realm.write {
            realm.add(item)
        }
    }

}
