//
//  StudentDataTableViewController.swift
//  CloudData
//
//  Created by mike on 2018/3/26.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

//要記得在 identity inspector 中設定 custom class
class StudentDataTableViewController: UITableViewController {

    var studentDataArray = [StudentData]()//存放要顯示用的資料的陣列
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem = editButtonItem//顯示 table view list 編輯按鈕
        
//        模擬從網路取得資料
        loadSamplesStudentData()
        
//        TODO:實際從網路取得資料
//        apiGithubComGloss.fetch(){ dataTransfer in//在區塊中實作 completion handler 要做的事
//            self.apiGithubComGlossJson = dataTransfer//把收到的資料放在這個類別的變數中
//            print("fetch() 完成後")
//            print(self.apiGithubComGlossJson)
//        }
    }
    
//            模擬從網路取得資料
    func loadSamplesStudentData() {
        //定幾點資料放到陣列中
        let studentData1 = StudentData(name: "mike", gender: "male", email: "mike@gmail.com")
        let studentData2 = StudentData(name: "Jack", gender: "male", email: "Jack@gmail.com")
        let studentData3 = StudentData(name: "John", gender: "male", email: "John@gmail.com")
        let studentData4 = StudentData(name: "Mary", gender: "female", email: "Mary@gmail.com")
        let studentData5 = StudentData(name: "Judy", gender: "female", email: "Judy@gmail.com")
        
        //將模擬資料放到陣列中
        studentDataArray += [studentData1, studentData2, studentData3, studentData4, studentData5]
    }
    
    //讓 IB 可以找到 segue 切換時，要使用的動作
    @IBAction func unwindToStudentDataList(sender: UIStoryboardSegue) {
        //檢查是從哪個頁面切過來的，檢查傳回來的資料
        if let sourceViewController = sender.source as? ViewController,
            let studentData = sourceViewController.studenDataTransfer {
            
//            判斷是否要更新 table view 的項目，或是新增項目
            if let selectedIndexPath = tableView.indexPathForSelectedRow {//如果是點選某一項，則更新該項的資料及 UI
                studentDataArray[selectedIndexPath.row] = studentData
                tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            } else {//如果沒有點選某一項，判斷為新增一筆資料
                let indexPath = IndexPath(row: studentDataArray.count, section: 0)
                studentDataArray.append(studentData)//把資料加到 list 用的資料陣列
                tableView.insertRows(at: [indexPath], with: .automatic)//更新 UI
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//要顯示 list 行數
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let number = studentDataArray.count//根據陣列資料數目顯示
        return number
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StudentDataTableViewCell"//使用在 UI 的 custom cell view 屬性中設定好的
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StudentDataTableViewCell//要轉成 custom cell view class 的類別
        
        // Configure the cell...
        let studentData = studentDataArray[indexPath.row]//取出對應的資料放在 cell 介面中
        
        cell.nameLabel.text = studentData.name
        cell.genderLabel.text = studentData.gender
        cell.emailLabel.text = studentData.email
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //需要同時刪除對應的資料，否則更新 table view list 時，會因為資料對不上而當掉
            studentDataArray.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? "") {//切換之前可以判斷用什麼方式
        case "AddStudentData":
            print("AddStudentData, prepare for segue")
        case "ShowStudentData":
            print("ShowStudentData, prepare for segue")
            guard let viewController = segue.destination as? ViewController else {
                fatalError("不是我們要切換的頁面")
            }
            
            guard let selectedStudentDataCell = sender as? StudentDataTableViewCell else {
                fatalError("不是我們點選的 cell 類別")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedStudentDataCell) else {
                fatalError("無法解出點選列的 index")
            }
            
            let selectedStudentData = studentDataArray[indexPath.row]//找到對應位置的資料
            viewController.studenDataTransfer = selectedStudentData//將資料放到目標頁面的變數中，準備顯示
            
        default:
            fatalError("segue identifier unknown...")
        }
    }

}
