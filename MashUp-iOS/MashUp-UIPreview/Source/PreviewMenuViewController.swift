//
//  ViewController.swift
//  MashUp-UIPreview
//
//  Created by Booung on 2022/06/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_UIKit
import MashUp_SignUpCode

final class PreviewMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "🧪 Preview 테스트"
        self.previewMenuTableView.dataSource = self
        self.previewMenuTableView.delegate = self
    }
    
    @IBOutlet private weak var previewMenuTableView: UITableView!
    
}

extension PreviewMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PreviewMenu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewMenuCell", for: indexPath)
        cell.textLabel?.text = menu(of: indexPath).description
        return cell
    }
    
    private func menu(of indexPath: IndexPath) -> PreviewMenu {
        return PreviewMenu.allCases[indexPath.row]
    }
    
}

extension PreviewMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = self.menu(of: indexPath)
        
        switch menu {
        case .signUpCode:
            self.navigationController?.pushViewController(SignUpCodeViewController(), animated: true)
        case .actionSheet:
            let actionSheet = MUActionSheetController(title: "플랫폼 선택")
            actionSheet.addAction(.init(title: "Product Design", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "Android", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "iOS", style: .selected, handler: nil))
            actionSheet.addAction(.init(title: "Web", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "Spring", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "Node", style: .default, handler: nil))
            actionSheet.present(on: self)
        case .alertView:
            let alertVC = MUActionAlertViewController(title: "이전 화면으로 이동하시겠어요?", message: "입력한 전체 내용이 삭제됩니다.")
            let action1 = MUAlertAction(title: "취소", style: .default) {
                alertVC.dismiss(animated: false)
            }
            let action2 = MUAlertAction(title: "확인", style: .primary) {
                print("확인")
            }
            alertVC.addAction(action1)
            alertVC.addAction(action2)
            present(alertVC, animated: false)
        }
    }
    
}
