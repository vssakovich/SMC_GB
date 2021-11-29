//
//  MyGroupsViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 21.10.21.
//

import UIKit

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuserIndetifierCustom = "reuserIndetifierCustom"
    
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    
    var myGroups = [Group]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: reuserIndetifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func isGroupAlreadyAdded(group: Group) -> Bool {
        return myGroups.contains { sourceGroup in
            sourceGroup.title == group.title
        }
    }
    
    @IBAction func goBackToMyGroupsSegue(segue: UIStoryboardSegue) {
        if segue.identifier == fromAllGroupsToMyGroupsSegue,
           let sourceViewController = segue.source as? AllGroupsViewController,
           let selectedGroup = sourceViewController.selectedGroup {
            if isGroupAlreadyAdded(group: selectedGroup) { return }
            self.myGroups.append(selectedGroup)
            tableView.reloadData()
        }
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuserIndetifierCustom, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configureForGroup(group: myGroups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
}

