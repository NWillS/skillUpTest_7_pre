//
//  FolderDao.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/04.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import Foundation

final class FolderDao{
    static let daoHelper = RealmDaoHelper<FolderDto>()
    
//    フォルダの追加
    static func addFolder(name:String){
        let folder = FolderDto()
        folder.folderId = FolderDao.daoHelper.newId()!
        folder.folderName = name
        folder.updateDate = Date()
        
        FolderDao.daoHelper.add(object: folder)
    }
//    フォルダの更新
    static func updateFolder(folder: FolderDto){
        guard let target = daoHelper.findFirst(key: folder.folderId as AnyObject) else {
            return
        }
        
        let newFolder = FolderDto()
        newFolder.folderId = target.folderId
        newFolder.folderName = folder.folderName
        newFolder.updateDate = Date()
        newFolder.tasks.append(objectsIn: folder.tasks)
        daoHelper.update(object: newFolder)
    }
//    フォルダの取得
    static func getFolder(folderId:Int) -> FolderDto?{
        guard let folder = FolderDao.daoHelper.findFirst(key: folderId as AnyObject) else{
            return nil
        }
        return folder
    }
//    フォルダの削除
    static func deleteFolder(folderId:Int){
        guard let folder = FolderDao.daoHelper.findFirst(key: folderId as AnyObject) else{
            return
        }
        folder.tasks.forEach {
            TaskDao.deleteTask(taskId: $0.taskId)
        }
        FolderDao.daoHelper.delete(object: folder)
    }
//    フォルダの全取得
    static func getAllFolders() -> [FolderDto]{
        let folderList = FolderDao.daoHelper.findAll().sorted(byKeyPath: "updateDate", ascending: false)
        return folderList.map { FolderDto(value: $0) }
    }
//    フォルダの全削除
    static func deleteAllFolders(){
        TaskDao.deleteAllTasks()
        FolderDao.daoHelper.deleteAll()
    }
    
//    フォルダ内の全Task取得
    static func getAllTaskIn(folderId:Int) -> [TaskDto]{
        let folder = FolderDao.getFolder(folderId: folderId)
        
        guard let tasks = folder?.tasks else {
            return []
        }
        return tasks.sorted { $0.updateDate > $1.updateDate }
    }
//    フォルダ内の全Task削除
    static func deleteAllTasksIn(folderId: Int) {
        
        if let folder = FolderDao.getFolder(folderId: folderId) {
            
            folder.tasks.forEach {
                TaskDao.deleteTask(taskId: $0.taskId)
            }
            FolderDao.updateFolder(folder: folder)
        }
    }

}
