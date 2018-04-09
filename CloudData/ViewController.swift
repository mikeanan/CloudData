//
//  ViewController.swift
//  CloudData
//
//  Created by mike on 2018/2/23.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {//修改成可以輸入
    var apiGithubComGlossJson: [apiGithubComGloss] = []

    @IBOutlet weak var nameTextField: UITextField!//修改成可以輸入
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func okButton(_ sender: UIButton) {
    }
    
    //直接從 IB 拖拉過來這裹即可
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {//2 個 segue 跳回上一頁的方式不同
        let isPresentingInAddItem = presentingViewController is UINavigationController
        if isPresentingInAddItem {
            dismiss(animated: true, completion: nil)//使用 modal 頁面時
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)//使用 show 頁面時
        } else {
            fatalError("not belong to any navigation controller")
        }
    }
    
    //直接從 IB 拖拉過來這裹即可
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //改用 apiGithubComGloss, githubDataTransfer
    var localhostDataTransfer: localhostStudents!//用來讓 segue 回傳資料用
    
    //segue 切換之前的 prepare function，可以用來檢查 sender 是誰
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as? UIBarButtonItem {
            let name = nameTextField.text ?? "No data"
            let gender = genderTextField.text ?? "No data"
            let email = emailTextField.text ?? "No data"
            
            //改用 apiGithubComGloss, githubDataTransfer
            localhostDataTransfer = localhostStudents(name: name, gender: gender, email: email)//自訂 init
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        TODO：要搬到程式起始處
        apiGithubComGloss.fetch(){ dataTransfer in//在區塊中實作 completion handler 要做的事
            self.apiGithubComGlossJson = dataTransfer//把收到的資料放在這個類別的變數中
            print("fetch() 完成後")
            print(self.apiGithubComGlossJson)
        }
        
        //解出傳過來的資料
        //改用 apiGithubComGloss, githubDataTransfer
        guard let githubDataTmp = localhostDataTransfer else {
//            fatalError("沒有傳進來的資料")
            return
        }
        
        //改用 githubDataTmp
        nameTextField.text = githubDataTmp.cName
        genderTextField.text = githubDataTmp.cSex
        emailTextField.text = githubDataTmp.cEmail
        
        nameTextField.delegate = self//修改成可以輸入
        genderTextField.delegate = self
        emailTextField.delegate = self
        
//        點選別的地方來收起鍵盤
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false//讓 tableView 可以正常運作
        view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//點選別的地方來收起鍵盤
        view.endEditing(true)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

