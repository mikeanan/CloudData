//
//  Helper.swift
//  CloudData
//
//  Created by mike on 2018/4/2.
//  Copyright © 2018年 mike. All rights reserved.
//

import Foundation

class Helper {//singleton pattern
    static let sharedInstance = Helper()
    
    var helperGithubDataArray: [apiGithubComGloss]?
    var helperLocalhostStudentsDataArray: [localhostStudents]?//localhost 資料
}
