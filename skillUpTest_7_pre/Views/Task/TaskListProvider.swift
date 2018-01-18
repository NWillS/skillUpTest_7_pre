//
//  TaskListProvider.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/09.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import STV_Extensions
import UIKit

class TaskListProvider: NSObject {
    var taskList: [TaskDto] = []
    
    func set(taskList: [TaskDto]) {
        self.taskList = taskList
    }
    func getTaskId(indexpath: IndexPath) -> Int {
        return taskList[indexpath.row].taskId
    }
    
}

extension TaskListProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "taskCell",
                                 for: indexPath) as? TaskCell else {
                                    fatalError("TaskCellが取得できない。")
        }
        
        cell.setTaskTitleText(text: taskList[indexPath.row].taskTitle)
        cell.setUpdateDateText(date: taskList[indexPath.row].updateDate.toStr(dateFormat: "yyyy/MM/dd"))
        
        return cell
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        let taskId = taskList[indexPath.row].taskId
        TaskDao.deleteTask(taskId: taskId)
        taskList.remove(at: indexPath.row)
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)],
                             with: .fade)
    }
}
