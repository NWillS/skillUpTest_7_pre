//
//  MocRealmFolder.swift
//  skillUpTest_7_preTests
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import XCTest
@testable import skillUpTest_7_pre

final class MocRealmFolder: XCTestCase {
    
    func mocRealmFolder() -> RealmDaoHelper<FolderDto> {
        return RealmDaoHelper<FolderDto>.init()
    }
    
    // MARK: - テスト用テキスト
    
    static let dummyName = ["zero", "one", "two", "three", "four"]
    
}
