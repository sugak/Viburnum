//
//  ConversationListViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 22/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationListViewController: UITableViewController, ManagerDelegate {
  // Creating empty array of existing blabbers (users)
  var blabbers: [Blabber] = []
  
  // Outlet for funny placeholder when on chat users:
  @IBOutlet var tablePlaceHolder: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    
    // Remove separator + large navbar title:
    self.tableView.separatorStyle = .none
    navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    //Themes: calling update function for current theme:
    updateForCurrentTheme()
    
    //Prepare for tableview placeholder:
    tableView.backgroundView = tablePlaceHolder
    tableView.backgroundView?.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super .viewWillAppear(Constants.animated)
    
    // Initilize Communication manager:
    CommunicationManager.shared.delegate = self
    globalUpdate()
  }
  
  func globalUpdate() {
    // Data transfer from Manager:
    blabbers = Array(CommunicationManager.shared.listOfBlabbers.values)
    sortBlabbers()
    tableView.reloadData()
  }
  
  // Sort function:
  func sortBlabbers() {
    blabbers.sort(by: sortFunc(first:second:))
  }
  
  func sortFunc(first: Blabber, second: Blabber) -> Bool {
    if let firstDate = first.messageDate.last, let firstName = first.name {
      if let secondDate = second.messageDate.last, let secondName = second.name {
        if firstDate.timeIntervalSinceNow != secondDate.timeIntervalSinceNow {
          return firstDate.timeIntervalSinceNow > secondDate.timeIntervalSinceNow
        }
        return firstName > secondName
      }
      return true
    } else  {
      return false
    }
  }
  
  // ----------- Другая сортировка, которая не работает ---------
  
  //  func sortFunc (first: Blabber, second: Blabber) -> Bool {
  //      if first.messageDate.last != second.messageDate.last {
  //        return first.messageDate.last!.timeIntervalSinceNow > second.messageDate.last!.timeIntervalSinceNow
  //      } else {
  //        return first.name! > second.name!
  //      }
  //  }
  
  
  // Tableview functions:
  override func numberOfSections(in tableView: UITableView) -> Int {
      return 1 //sections.count
    }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Online"  //sections[section]
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if blabbers.count > 0 {
      tableView.backgroundView?.isHidden = true
    } else {
      tableView.backgroundView?.isHidden = false
    }
    return blabbers.count //TalkerName[section].count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "conversationСell", for: indexPath) as! ConversationListTableViewCell
    
    let conversation = blabbers[indexPath.row]
    cell.name = conversation.name
    cell.avatarSymbols = conversation.name ?? "XX"
    cell.message = conversation.message.last
    cell.date = conversation.messageDate.last
    cell.hasUnreadMessages = conversation.hasUnreadMessages
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
        
        // Tranfer blabber info:
        let blabberChat = blabbers[indexPath.row]
        destinationController.blabberChat = blabberChat
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
