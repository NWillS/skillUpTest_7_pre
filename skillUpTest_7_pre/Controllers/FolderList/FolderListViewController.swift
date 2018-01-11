//
//  FolderListViewController.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import UIKit
import Alertift

class FolderListViewController: UIViewController {

    let dataSource = FolderListProvider()
    
    @IBOutlet weak var folderTableView: UITableView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        folderTableView.dataSource = dataSource
        folderTableView.delegate = self
        folderTableView.allowsSelectionDuringEditing = true
        
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
        if(folderTableView.isEditing){
            rightBarButtonItem.title = "すべて削除"
        }else{
            rightBarButtonItem.title = "新規フォルダ"
        }
    }
    @IBAction func tappedRightBarButtonItem(_ sender: UIBarButtonItem) {
        if(folderTableView.isEditing){
//            すべて削除
            showActionSheet()
        }else{
//            フォルダ追加
            Alertift.alert(title: "", message: "このフォルダの名前を入力してください。")
                .textField{ textField in
                    textField.placeholder = "このフォルダの名前を入力してください。"
                }
                .action(.cancel("キャンセル"))
                .action(.default("保存")) { _, _, textFields in
                    let name = textFields?.first?.text ?? ""
                    if (name == ""){
                        return
                    }
                    FolderDao.addFolder(name: name)
                    self.reloadFolderList()
                }
                .show(on: self)
        }
    }
    func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "すべて削除", style: .destructive) { [weak self] (action) in
            
            guard let `self` = self else { return }
            FolderDao.deleteAllFolders()
            self.reloadFolderList()
            self.setEditing(false, animated: true)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func reloadFolderList() {
        dataSource.set(folderList: FolderDao.getAllFolders())
        folderTableView.reloadData()
    }
}
extension FolderListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(folderTableView.isEditing){
            let folder = dataSource.folderList[indexPath.row]
            Alertift.alert(title: folder.folderName, message: "このフォルダの新しい名前を入力してください。")
                .textField{ textField in
                    textField.text = folder.folderName
                }
                .action(.cancel("キャンセル"))
                .action(.default("保存")) { _, _, textFields in
                    let name = textFields?.first?.text ?? ""
                    if (name == "" || name == folder.folderName){
                        return
                    }
                    let updateFolder = FolderDto()
                    updateFolder.folderId = folder.folderId
                    updateFolder.folderName = name
                    updateFolder.tasks.append(objectsIn: folder.tasks)
                    
                    FolderDao.updateFolder(folder: updateFolder)
                    self.reloadFolderList()
                }
                .show()
        }else{
            let folder = dataSource.folderList[indexPath.row]
            let taskListSB = UIStoryboard(name: "TaskList", bundle: nil)
            let taskListVC = taskListSB.instantiateInitialViewController() as! TaskListViewController
            
            taskListVC.folder = folder
            navigationController?.pushViewController(taskListVC, animated: true)
        }
    }
}

