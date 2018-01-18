//
//  AlertHelper.swift
//  skillUpTest_7_pre
//
//  Created by S N on 2018/01/12.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import Alertift
import Foundation

enum AlertHelperType {
    case add
    case update(index:Int)
}

protocol AlertHelperDelegate: class {
    func receivedName(name: String, type: AlertHelperType)
    func deleteAll()
}

class AlertHelper: NSObject {
    weak var delegate: AlertHelperDelegate?
    func showAlert(title: String, message: String, type: AlertHelperType) {
        Alertift.alert(title: title, message: message)
            .textField { textField in
                if title == "" {
                    textField.placeholder = message
                } else {
                    textField.text = title
                }
            }
            .action(.cancel("キャンセル"))
            .action(.default("保存"), isPreferred: true, handler: { (_, _, textField) in
                let name = textField?.first?.text ?? ""
                if name == "" {
//                    Alertift.alert(title: "追加できませんでした", message: "1文字以上入力してください")
//                        .titleTextColor(.red)
//                        .action(.default("OK"), handler: { (_, _, _) in
//                            self.showAlert(title: title, message: message, type: type)
//                        })
//                        .show()
                    return
                }
                
                self.delegate?.receivedName(name: name, type: type)
            })
            .show()
        
    }
    func delete() {
        Alertift.ActionSheet()
            .action(.destructive("すべて削除"))
            .action(.cancel("キャンセル"))
            .finally { action, _  in
                if action.style == .cancel {
                    return
                }
                self.delegate?.deleteAll()
            }
            .show()
    }
}
