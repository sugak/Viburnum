//
//  ConversationListViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 22/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationListViewController: UITableViewController, ManagerDelegate {
  
  var blabberChat: [Blabber] = [] // Creating array of possible blabbers (users)
  
  func globalUpdate() {
    blabberChat = Array(CommunicationManager.shared.conversationDictionary.values)
    //sortUserConversations()
    tableView.reloadData()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    
    // Remove separator + large navbar title:
    self.tableView.separatorStyle = .none
    navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    //Themes: calling update function for current theme:
    updateForCurrentTheme()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super .viewWillAppear(Constants.animated)
    
    // Initilize Communication manager:
    CommunicationManager.shared.delegate = self
  }
  
  // Tableview functions:
  override func numberOfSections(in tableView: UITableView) -> Int {
      // As in array:
      return sections.count
    }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // As in array:
    return sections[section]
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return blabberChat.count //TalkerName[section].count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "conversationСell", for: indexPath) as! ConversationListTableViewCell
    
    let blabber = blabberChat[indexPath.row]
    cell.name = blabber.name
    
//    cell.name = TalkerName[indexPath.section][indexPath.row]
//    cell.hasUnreadMessages = ifMessageUnread[indexPath.section][indexPath.row]
//    cell.message = lastMessage[indexPath.section][indexPath.row]
//    cell.online = ifOnline[indexPath.section][indexPath.row]
//    cell.avatarSymbols = TalkerName[indexPath.section][indexPath.row]
    
    // Decoding date from String source:
//    let formatter  = DateFormatter()
//    formatter.dateFormat = "dd.MM.yyyy HH:mm"
//    let messageDateFromString: Date?
//    messageDateFromString = formatter.date(from: stringDate[indexPath.section][indexPath.row] ?? "nil")
//    cell.date = messageDateFromString
    
    return cell
  }
  
  // Segue to chat:
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showConversation" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as!
        ConversationViewController
        
        // Transfer name into navbar:
        let cell = tableView.cellForRow(at: indexPath) as! ConversationListTableViewCell
        destinationController.navigationItem.title = cell.name
      }
    }
    
    //Themes: segue to ThemeViewController:
    if segue.identifier == "themeMenu" {
      guard let navController = segue.destination as? UINavigationController else {return}
      let destination = navController.topViewController as! ThemesViewController
      
      // Themes class protocol:
      destination.themeProtocol = { [weak self] (selectedTheme: UIColor) in
      self?.logThemeChanging(selectedTheme: selectedTheme) }
      
    }
  }
  
  // Function for ThemesView delegate and closure:
  func logThemeChanging(selectedTheme: UIColor) {
    print(selectedTheme)
  }
  
  //Themes: update function for current theme with User Defaults:
  func updateForCurrentTheme () {
    if let currentTheme = UserDefaults.standard.colorForKey(key: "currentTheme") {
       UINavigationBar.appearance().barTintColor = currentTheme
    } else {
      UserDefaults.standard.setColor(value: UIColor.white, forKey: "currentTheme")
      updateForCurrentTheme()
    }
    
    // Views updating:
    let windows = UIApplication.shared.windows
    for window in windows {
      for view in window.subviews {
        view.removeFromSuperview()
        window.addSubview(view)
      }
    }
  }
}

//MARK: - Themes: extention for passing and reading UIColor in User Defaults:
extension UserDefaults {
  func setColor(value: UIColor?, forKey: String) {
    guard let value = value else {
      set(nil, forKey:  forKey)
      return
    }
    set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: forKey)
  }
  func colorForKey(key:String) -> UIColor? {
    guard let data = data(forKey: key), let color = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
      else { return nil }
    return color
  }
}
