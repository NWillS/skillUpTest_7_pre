//
//  FolderDaoTests.swift
//  skillUpTest_7_preTests
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import XCTest
@testable import skillUpTest_7_pre

class FolderDaoTests: XCTestCase {
    var moc = MocRealmFolder()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moc = MocRealmFolder()
        moc.mocRealmFolder().deleteAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //    Folder追加
    func testAddFolder(){
//        setup
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 0)
        
        let folderName = MocRealmFolder.dummyName[0]
        
//        exercise
        FolderDao.addFolder(name: folderName)
        
//        verify
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmFolder().findFirst(key: 1 as AnyObject)?.folderName, MocRealmFolder.dummyName[0])
    }
    
    //    Folder更新
    func testUpdateFolder(){
//        setup
        FolderDao.addFolder(name: MocRealmFolder.dummyName[0])
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmFolder().findFirst(key: 1 as AnyObject)?.folderName, MocRealmFolder.dummyName[0])
        
        let savedFolder = moc.mocRealmFolder().findFirst()
        
        let updateFolder = FolderDto()
        updateFolder.folderId = (savedFolder?.folderId)!
        updateFolder.folderName = MocRealmFolder.dummyName[1]
        
//        exercise
        FolderDao.updateFolder(folder: updateFolder)
        
//        verify
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmFolder().findFirst(key: 1 as AnyObject)?.folderName, MocRealmFolder.dummyName[1])
    }
    //    Folder取得
    func testGetFolder(){
//        setup
        FolderDao.addFolder(name: MocRealmFolder.dummyName[0])
        
//        exercise
        guard let gotFolder = FolderDao.getFolder(folderId: 1) else{
            return
        }
        
//        verify
        XCTAssertEqual(gotFolder.folderName, MocRealmFolder.dummyName[0])
    }
    //    Folder削除
    func testDeleteFolder(){
//        setup
        FolderDao.addFolder(name: MocRealmFolder.dummyName[0])
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmFolder().findFirst(key: 1 as AnyObject)?.folderName, MocRealmFolder.dummyName[0])
        
//        exercise
        FolderDao.deleteFolder(folderId: 1)
        
//        verify
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 0)
    }
    //    Folder全取得
    func testGetAllFolder(){
//        setup
        FolderDao.addFolder(name: MocRealmFolder.dummyName[0])
        FolderDao.addFolder(name: MocRealmFolder.dummyName[1])
        FolderDao.addFolder(name: MocRealmFolder.dummyName[2])
        
//        exercise
        let results = FolderDao.getAllFolders()
        
//        verify
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 3)
        XCTAssertEqual(results.count, 3)
        
    }
    //    Folder全削除
    func testDeleteAllFolders(){
//        setup
        FolderDao.addFolder(name: MocRealmFolder.dummyName[0])
        FolderDao.addFolder(name: MocRealmFolder.dummyName[1])
        FolderDao.addFolder(name: MocRealmFolder.dummyName[2])
        
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 3)
        
//        exercise
        FolderDao.deleteAllFolders()
        
//        verify
        XCTAssertEqual(moc.mocRealmFolder().findAll().count, 0)
    }
    
}
