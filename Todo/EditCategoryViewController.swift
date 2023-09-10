//
//  EditCategoryViewController.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/10.
//

import UIKit
import RealmSwift

class EditCategoryViewController: UIViewController {
    
    let realm = try! Realm()
    var category: Category!
    @IBOutlet var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleTextField.text = category.title
    }
    
    @IBAction func save(){
        let targetItem = realm.objects(Category.self).where({$0.id == category.id}).first!
        try! realm.write{
            targetItem.title = titleTextField.text ?? ""
        }
        
        navigationController?.popViewController(animated: true)
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
