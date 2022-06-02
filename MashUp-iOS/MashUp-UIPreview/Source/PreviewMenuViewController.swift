//
//  ViewController.swift
//  MashUp-UIPreview
//
//  Created by Booung on 2022/06/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

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
        let targetViewController = self.viewController(of: menu)
        self.navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    private func viewController(of menu: PreviewMenu) -> UIViewController {
        switch menu {
        // Dynamic Library 에서 테스트하고 싶은 UI 추가
        case .button: return UIViewController()
        }
    }
    
}
