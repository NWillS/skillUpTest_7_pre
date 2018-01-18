//
//  FolderListViewController.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import UIKit

class FolderListViewController: UIViewController {

    let dataSource = FolderListProvider()
    let alert = AlertHelper()
    
    @IBOutlet weak private var folderTableView: UITableView!
    @IBOutlet weak private var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        folderTableView.dataSource = dataSource
        folderTableView.delegate = self
        folderTableView.allowsSelectionDuringEditing = true
        
        alert.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadFolderList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        folderTableView.isEditing = !folderTableView.isEditing
        if folderTableView.isEditing {
            rightBarButtonItem.title = "すべて削除"
        } else {
            rightBarButtonItem.title = "新規フォルダ"
        }
    }
    @IBAction func tappedRightBarButtonItem(_ sender: UIBarButtonItem) {
        if folderTableView.isEditing {
//            すべて削除
            alert.delete()
        } else {
//            フォルダ追加
            alert.showAlert(title: "", message: "このフォルダの名前を入力してください。", type: .add)
        }
    }
    func reloadFolderList() {
        dataSource.set(folderList: FolderDao.getAllFolders())
        folderTableView.reloadData()
    }
}
extension FolderListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if folderTableView.isEditing {
            let folder = dataSource.folderList[indexPath.row]
            alert.showAlert(title: folder.folderName,
                            message: "このフォルダの新しい名前を入力してください。",
                            type: .update(index: indexPath.row))
        } else {
            let folder = dataSource.folderList[indexPath.row]
            let taskListSB = UIStoryboard(name: "TaskList", bundle: nil)
            guard let taskListVC = taskListSB.instantiateInitialViewController() as? TaskListViewController else {
                return
            }
            
            taskListVC.folder = folder
            navigationController?.pushViewController(taskListVC, animated: true)
        }
    }
}
extension FolderListViewController: AlertHelperDelegate {
    func receivedName(name: String, type: AlertHelperType) {
        switch type {
        case .add:
            FolderDao.addFolder(name: name)
        case .update(let index):
            let folder = dataSource.folderList[index]
            let updateFolder = FolderDto()
            updateFolder.folderId = folder.folderId
            updateFolder.folderName = name
            updateFolder.tasks.append(objectsIn: folder.tasks)
            
            FolderDao.updateFolder(folder: updateFolder)
        }
        
        reloadFolderList()
    }
    func deleteAll() {
        FolderDao.deleteAllFolders()
        reloadFolderList()
        setEditing(false, animated: true)
    }
}
