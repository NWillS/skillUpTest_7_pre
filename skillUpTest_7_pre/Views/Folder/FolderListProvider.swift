//
//  FolderListProvider.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import UIKit

class FolderListProvider: NSObject {
    var folderList:[FolderDto] = []
    
    func set(folderList:[FolderDto]){
        self.folderList = folderList
    }
}
extension FolderListProvider:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell")as! FolderCell
        
        cell.NameLabel.text = folderList[indexPath.row].folderName
        cell.countLabel.text = "\(folderList[indexPath.row].tasks.count)"
        
        return cell
    }
    
    
}
