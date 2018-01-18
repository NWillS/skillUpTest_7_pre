//
//  FolderDto.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/04.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import Foundation
import RealmSwift

final class FolderDto: Object {
    @objc dynamic var folderId = 0
    @objc dynamic var folderName = ""
    @objc dynamic var updateDate = Date()
    let tasks = List<TaskDto>() 
    
    override static func primaryKey() -> String? {
        return "folderId"
    }
    func getListCount() -> Int {
        return tasks.count
    }
}
