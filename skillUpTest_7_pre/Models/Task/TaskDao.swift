//
//  TaskDao.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/04.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import Foundation

final class TaskDao{
    static let daoHelper = RealmDaoHelper<TaskDto>()
    
//    Task追加
    static func addTask(title:String){
        let task = TaskDto()
        task.taskId = TaskDao.daoHelper.newId()!
        task.taskTitle = title
        task.updateDate = Date()
        
        TaskDao.daoHelper.add(object: task)
    }
//    Task更新
    static func updateTask(task:TaskDto){
        TaskDao.daoHelper.update(object: task)
    }
//    Task取得
    static func getTask(taskId:Int)-> TaskDto?{
        guard let task = TaskDao.daoHelper.findFirst(key: taskId as AnyObject) else{
            return nil
        }
        return task
    }
//    Task削除
    static func deleteTask(taskId:Int){
        guard let task = TaskDao.daoHelper.findFirst(key: taskId as AnyObject) else{
            return
        }
        TaskDao.daoHelper.delete(object: task)
    }

//    Task全取得
    static func getAllTasks() -> [TaskDto]{
        let taskList = TaskDao.daoHelper.findAll().sorted(byKeyPath: "updateDate", ascending: false)
        return taskList.map { TaskDto(value: $0) }
    }

//    Task全削除
    static func deleteAllTasks(){
        TaskDao.daoHelper.deleteAll()
    }
}
