//
//  ViewController.swift
//  CloudData
//
//  Created by mike on 2018/2/23.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func okButton(_ sender: UIButton) {
    }
    
    //直接從 IB 拖拉過來這裹即可
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //直接從 IB 拖拉過來這裹即可
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var studenDataTransfer: StudentData!//用來讓 segue 回傳資料用
    
    //segue 切換之前的 prepare function，可以用來檢查 sender 是誰
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as? UIBarButtonItem {
            let name = nameLabel.text ?? "No data"
            let gender = genderLabel.text ?? "No data"
            let email = emailLabel.text ?? "No data"
            
            studenDataTransfer = StudentData(name: name, gender: gender, email: email)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

