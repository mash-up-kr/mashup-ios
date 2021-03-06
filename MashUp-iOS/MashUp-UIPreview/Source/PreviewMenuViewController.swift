//
//  ViewController.swift
//  MashUp-UIPreview
//
//  Created by Booung on 2022/06/01.
//  Copyright ยฉ 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_UIKit
import MashUp_SignUpCode

final class PreviewMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "๐งช Preview ํ์คํธ"
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
            let actionSheet = MUActionSheetController(title: "ํ๋ซํผ ์ ํ")
            actionSheet.addAction(.init(title: "Product Design", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "Android", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "iOS", style: .selected, handler: nil))
            actionSheet.addAction(.init(title: "Web", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "Spring", style: .default, handler: nil))
            actionSheet.addAction(.init(title: "Node", style: .default, handler: nil))
            actionSheet.present(on: self)
        case .alertView:
            let alertVC = MUActionAlertViewController(title: "์ด์  ํ๋ฉด์ผ๋ก ์ด๋ํ์๊ฒ ์ด์?", message: "์๋ ฅํ ์ ์ฒด ๋ด์ฉ์ด ์ญ์ ๋ฉ๋๋ค.")
            let action1 = MUAlertAction(title: "์ทจ์", style: .default) {
                alertVC.dismiss(animated: false)
            }
            let action2 = MUAlertAction(title: "ํ์ธ", style: .primary) {
                print("ํ์ธ")
            }
            alertVC.addAction(action1)
            alertVC.addAction(action2)
            present(alertVC, animated: false)
        }
    }
    
}
