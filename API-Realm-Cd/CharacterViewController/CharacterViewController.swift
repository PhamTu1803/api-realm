//
//  CharacterViewController.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class CharacterViewController: UIViewController {
    var listData:[CharacterModel] = [CharacterModel]()
    func getCharacter(andCompletion completion:@escaping (_ moviesResponse: [CharacterModel], _ error: Error?) -> ()) {
        APIService.shared.GetCharacter() { (response, error) in
            if let listData = response{
                self.listData = listData
                DispatchQueue.main.async {
                    self.characterTbview.reloadData()
                }
            }
            completion(self.listData, error)
        }
    }
    @IBOutlet weak var characterTbview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        
        
    }
    //MARK:- initTableView
    private func initTableView() {
        characterTbview.register(UINib(nibName: "Charactercell", bundle: nil), forCellReuseIdentifier: "Charactercell")
        characterTbview.delegate = self
        characterTbview.dataSource = self
        self.getCharacter(){_,_ in}
    }
    
}
//MARK: - Extension
extension CharacterViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Charactercell", for: indexPath) as! Charactercell
        
        cell.lblname.text = "Name : " + listData[indexPath.row].name
        cell.lblgender.text = "Gender : " + listData[indexPath.row].gender
        cell.lblstatus.text = "Status : " + listData[indexPath.row].status
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
