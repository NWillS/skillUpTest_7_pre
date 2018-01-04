//
//  TaskDto.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/04.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import Foundation
import RealmSwift

final class TaskDto: Object{
    @objc dynamic var taskId = 0
    @objc dynamic var taskTitle = ""
    @objc dynamic var updateDate = Date()
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
}
