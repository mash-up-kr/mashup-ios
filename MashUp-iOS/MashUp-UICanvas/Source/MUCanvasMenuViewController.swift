//
//  ViewController.swift
//  MashUp-UICanvas
//
//  Created by Booung on 2022/06/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

final class MUCanvasMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canvasMenuTableView.dataSource = self
        self.canvasMenuTableView.delegate = self
    }
    
    @IBOutlet private weak var canvasMenuTableView: UITableView!
    
}

extension MUCanvasMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MUCanvasMenu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MUCanvasMenuCell", for: indexPath)
        cell.textLabel?.text = menu(of: indexPath).description
        return cell
    }
    
    private func menu(of indexPath: IndexPath) -> MUCanvasMenu {
        return MUCanvasMenu.allCases[indexPath.row]
    }
    
}

extension MUCanvasMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = self.menu(of: indexPath)
        let targetViewController = self.viewController(of: menu)
        self.navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    private func viewController(of menu: MUCanvasMenu) -> UIViewController {
        switch menu {
        // 테스트 하고 싶은 MashUp-UIKit 요소 테스트
        case .button: return UIViewController()
        }
    }
    
}
