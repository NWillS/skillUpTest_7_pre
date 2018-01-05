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
    
    @IBOutlet weak var folderTableView: UITableView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        folderTableView.dataSource = dataSource
        folderTableView.delegate = self
        
        FolderDao.deleteAllFolders()
        for _ in 0...5{
            FolderDao.addFolder(name: "Test")
        }
        reloadFolderList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func reloadFolderList() {
        dataSource.set(folderList: FolderDao.getAllFolders())
        folderTableView.reloadData()
    }

}
extension FolderListViewController:UITableViewDelegate{
    
}
