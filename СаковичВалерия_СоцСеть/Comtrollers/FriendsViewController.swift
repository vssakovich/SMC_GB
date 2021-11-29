//
//  FriendsViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 21.10.21.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let reuserIndetifierCustom = "reuserIndetifierCustom"
    let fromFriendToGallerySegue = "fromFriendToGallery"
    
    var friendsList = [Friend]()
    var initialFriendsList = [Friend]()
    
    var letterList = [String]()
    
    func fillUsersArray() {
        let user1 = Friend(name: "Alice Cullen", avatar: UIImage(named: "Alice")!, photos: [UIImage(named: "Alice")!, UIImage(named: "Alice2")!, UIImage(named: "Alice3")!])
        let user2 = Friend(name: "Bella Cullen", avatar: UIImage(named: "Bella")!, photos: [UIImage(named: "Bella")!, UIImage(named: "Bella2")!, UIImage(named: "Bella3")!])
        let user3 = Friend(name: "Edward Cullen", avatar: UIImage(named: "Edward")!, photos: [UIImage(named: "Edward")!])
        let user4 = Friend(name: "Emmett Cullen", avatar: UIImage(named: "Emmett")!, photos: [UIImage(named: "Emmett")!])
        let user5 = Friend(name: "Jasper Cullen", avatar: UIImage(named: "Jasper")!, photos: [UIImage(named: "Jasper")!])
        let user6 = Friend(name: "Rosalie Cullen", avatar: UIImage(named: "Rosalie")!, photos: [UIImage(named: "Rosalie")!])
        
        friendsList.append(user1)
        friendsList.append(user2)
        friendsList.append(user3)
        friendsList.append(user4)
        friendsList.append(user5)
        friendsList.append(user6)
    }
    
    func createFirstNameLetterArray(sourceArray: [Friend]) -> [String] {
        var lettersList = [String]()
        for item in sourceArray {
            let nameLetter = String(item.name.prefix(1))
            if !lettersList.contains(nameLetter) {
                lettersList.append(nameLetter)
            }
        }
        return lettersList
    }
    
    func createLetterList() {
        self.letterList = createFirstNameLetterArray(sourceArray: friendsList)
    }
    
    func sortFriendsListByLetters(sourceArray: [Friend], letter: String) -> [Friend] {
        var sortedFriendsList = [Friend]()
        for item in sourceArray {
            let nameLetter = String(item.name.prefix(1))
            if nameLetter == letter {
                sortedFriendsList.append(item)
            }
        }
        return sortedFriendsList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUsersArray()
        createLetterList()
        initialFriendsList = friendsList
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: reuserIndetifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendToGallerySegue,
//           let sourceViewController = segue.source as? FriendsViewController,
           let destinationViewController = segue.destination as? GalleryViewController,
           let friend = sender as? Friend {
            destinationViewController.photos = friend.photos
        }
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return letterList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortFriendsListByLetters(sourceArray: friendsList, letter: self.letterList[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuserIndetifierCustom, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configureForFriend(friend: sortFriendsListByLetters(sourceArray: friendsList, letter: letterList[indexPath.section])[indexPath.row], completion: {
                                    [weak self] friend in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.fromFriendToGallerySegue, sender: friend)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: fromFriendToGallerySegue, sender: sortFriendsListByLetters(sourceArray: friendsList, letter: letterList[indexPath.section])[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return letterList[section].uppercased()
    }
}

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.friendsList = self.initialFriendsList
        } else {
            self.friendsList = self.friendsList.filter({ friend in friend.name.lowercased().contains(searchText.lowercased())})
        }
        createLetterList()
        self.tableView.reloadData()
    }
}
