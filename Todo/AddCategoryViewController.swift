//
//  AddCategoryViewController.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/10.
//

import UIKit
import RealmSwift
class AddCategoryViewController: UIViewController {

    let realm = try! Realm()
    @IBOutlet var titleTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(){
        let category = Category()
        category.title = titleTextField.text  ?? ""
        createCategory(category: category)
        
        navigationController?.popViewController(animated: true)
    }
    
    func createCategory(category: Category) {
        try! realm.write {
            realm.add(category)
        }
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
