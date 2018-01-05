//
//  FolderDtoTests.swift
//  skillUpTest_7_preTests
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import XCTest
@testable import skillUpTest_7_pre

class FolderDtoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFolderDto(){
//        MARK:FolderDtoに値をセット
//        setup
        let folderId = 1
        let folderName = "name"
        let updateDate = Date()
        
//        exercise
        let folder = FolderDto()
        folder.folderId = folderId
        folder.folderName = folderName
        folder.updateDate = updateDate
        
//        verify
        XCTAssertEqual(folder.folderId, 1)
        XCTAssertEqual(folder.folderName, "name")
        XCTAssertEqual(folder.updateDate, updateDate)
        
    }
    
}
