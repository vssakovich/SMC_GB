//
//  AllGroupsViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 21.10.21.
//

import UIKit

class AllGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuserIndetifierCustom = "reuserIndetifierCustom"
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    
    var allGroups = [Group]()
    
    var selectedGroup: Group?
    
    func fillAllGroup() {
        let group1 = Group(title: "Twilight Family", avatar: UIImage(named: "TwilightFamily")!)
        allGroups.append(group1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillAllGroup()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: reuserIndetifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuserIndetifierCustom, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configureForGroup(group: allGroups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedGroup = allGroups[indexPath.row]
        performSegue(withIdentifier: fromAllGroupsToMyGroupsSegue, sender: nil)
    }
}
