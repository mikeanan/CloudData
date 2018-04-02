//
//  ViewController.swift
//  CloudData
//
//  Created by mike on 2018/2/23.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var apiGithubComGlossJson: [apiGithubComGloss] = []

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
    var githubDataTransfer: apiGithubComGloss!//用來讓 segue 回傳資料用
    
    //segue 切換之前的 prepare function，可以用來檢查 sender 是誰
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as? UIBarButtonItem {
            let name = nameLabel.text ?? "No data"
            let gender = genderLabel.text ?? "No data"
            let email = emailLabel.text ?? "No data"
            
            //改用 apiGithubComGloss, githubDataTransfer
            githubDataTransfer = apiGithubComGloss(name: name, gender: gender, email: email)//自訂 init
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
        guard let githubDataTmp = githubDataTransfer else {
//            fatalError("沒有傳進來的資料")
            return
        }
        
        //改用 githubDataTmp
        nameLabel.text = githubDataTmp.name
        genderLabel.text = githubDataTmp.url
        emailLabel.text = githubDataTmp.full_name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

