//
//  ConversationListViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 22/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

/*
 
                            === ЧЕКЛИСТ ===
            для переключения между классами Objective-C & Swift
 
 1. Сменить Target Membership
 2. Проверить Custom Class в IB
 3. В ConversationListViewController:
 
 3.1 Для перехода в Swift:
 3.1.1 В segue "themeMenu" раскомментить блок //For Swift class usage:
 3.1.2 Там же закомментить блок // For Objective-C class usage:
 3.1.3 Закомментить extension ConversationListViewController: ThemesViewControllerDelegate в конце кода.
 
 3.2 Для перехода в Obj-C:
 3.2.1 В segue "themeMenu" закомментить блок //For Swift class usage:
 3.2.2 Там же раскомментить блок // For Objective-C class usage:
 3.2.3 Раскомментить extension ConversationListViewController: ThemesViewControllerDelegate в конце кода.
 
 */

import UIKit

class ConversationListViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    
    // Remove separator + large navbar title:
    self.tableView.separatorStyle = .none
    navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    //MARK: - Themes: calling update function for current theme:
    updateForCurrentTheme()
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
    return TalkerName[section].count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "conversationСell", for: indexPath) as! ConversationListTableViewCell
      
    cell.name = TalkerName[indexPath.section][indexPath.row]
    cell.hasUnreadMessages = ifMessageUnread[indexPath.section][indexPath.row]
    cell.message = lastMessage[indexPath.section][indexPath.row]
    cell.online = ifOnline[indexPath.section][indexPath.row]
    cell.avatarSymbols = TalkerName[indexPath.section][indexPath.row]
    
    // Decoding date from String source:
    let formatter  = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy HH:mm"
    let messageDateFromString: Date?
    messageDateFromString = formatter.date(from: stringDate[indexPath.section][indexPath.row] ?? "nil")
    cell.date = messageDateFromString
    
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
    
    //MARK: - Themes: segue to ThemeViewController:
    if segue.identifier == "themeMenu" {
      guard let navController = segue.destination as? UINavigationController else {return}
      let destination = navController.topViewController as! ThemesViewController
      
      // For Swift class usage:
      //destination.themeProtocol = { [weak self] (selectedTheme: UIColor) in
      //self?.logThemeChanging(selectedTheme: selectedTheme) }
      
      // For Objective-C class usage:
      destination.delegate = self
    }
  }
  
  // Function for ThemesView delegate and closure:
  func logThemeChanging(selectedTheme: UIColor) {
    print(selectedTheme)
  }
  
  // MARK: - Themes: update function for current theme with User Defaults:
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

extension ConversationListViewController: ThemesViewControllerDelegate {
  func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
    logThemeChanging(selectedTheme: selectedTheme)
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
