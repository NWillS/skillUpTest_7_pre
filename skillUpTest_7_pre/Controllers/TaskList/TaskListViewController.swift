//
//  TaskListViewController.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/09.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import UIKit
import Alertift

class TaskListViewController: UIViewController {
    
    let dataSource = TaskListProvider()
    let alert = AlertHelper()
    
    var folder:FolderDto!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.dataSource = dataSource
        taskTableView.delegate = self
        taskTableView.allowsSelectionDuringEditing = true
        
        alert.delegate = self
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        title = folder.folderName
        
         reloadTaskList()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        taskTableView.isEditing = !taskTableView.isEditing
        if(taskTableView.isEditing){
            rightBarButtonItem.title = "すべて削除"
        }else{
            rightBarButtonItem.title = "タスク追加"
        }
    }
    @IBAction func tappedRightBarButtonItem(_ sender: UIBarButtonItem) {
        if(taskTableView.isEditing){
            //            すべて削除
            alert.delete()
        }else{
            //            フォルダ追加
            alert.showAlert(title: "", message: "このタスクの名前を入力してください。", type: .add)
        }
    }
    func addTask(name:String){
        let taskId = TaskDao.addTask(title: name)
        if let newTask:TaskDto = TaskDao.getTask(taskId: taskId){
            folder.tasks.append(newTask)
            FolderDao.updateFolder(folder: folder)
            
        }
    }

    func reloadTaskList() {
        dataSource.set(taskList: FolderDao.getAllTaskIn(folderId: folder.folderId))
        taskTableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TaskListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(taskTableView.isEditing){
            let task = FolderDao.getAllTaskIn(folderId: folder.folderId)[indexPath.row]
            alert.showAlert(title: task.taskTitle, message: "このタスクの新しい名前を入力してください。", type: .update(index: indexPath.row))
        }
    }
}
extension TaskListViewController:AlertHelperDelegate{
    func receivedName(name: String,type:AlertHelperType) {
        switch type {
        case .add:
            addTask(name: name)
        case .update(let index):
            let task = FolderDao.getAllTaskIn(folderId: folder.folderId)[index]
            let updateTask = TaskDto()
            updateTask.taskId = task.taskId
            updateTask.taskTitle = name
            
            TaskDao.updateTask(task: updateTask)
        }
        
        reloadTaskList()
    }
    func deleteAll() {
        FolderDao.deleteAllTasksIn(folderId: self.folder.folderId)
        self.reloadTaskList()
        self.setEditing(false, animated: true)
    }
}
