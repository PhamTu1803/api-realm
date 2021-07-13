//
//  EpisodeViewController.swift
//  API-Realm-Cd
//
//  Created by phamtu on 09/07/2021.
//

import UIKit

class EpisodeViewController: UIViewController {
    var listData:[EpisodeModel] = [EpisodeModel]()
    func getEpisode(andCompletion completion:@escaping (_ moviesResponse: [EpisodeModel], _ error: Error?) -> ()) {
        APIService.shared.GetEpisode() { (response, error) in
            if let listData = response{
                self.listData = listData
                DispatchQueue.main.async {
                    self.episodeTbview.reloadData()
                }
            }
            completion(self.listData, error)
        }
    }
    @IBOutlet weak var episodeTbview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
    }
//MARK:- initTableView
    private func initTableView() {
        episodeTbview.register(UINib(nibName: "Charactercell", bundle: nil), forCellReuseIdentifier: "Charactercell")
        episodeTbview.delegate = self
        episodeTbview.dataSource = self
        self.getEpisode(){_,_ in}
    }
}
//MARK:- Extention
extension EpisodeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Charactercell", for: indexPath) as! Charactercell
        cell.lblname.text = "Name : " + listData[indexPath.row].name
        cell.lblgender.text = "Air date : " + listData[indexPath.row].air_date
        cell.lblstatus.text = "Episode : " + listData[indexPath.row].episode
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
