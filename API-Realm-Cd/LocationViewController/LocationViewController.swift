//
//  LocationViewController.swift
//  API-Realm-Cd
//
//  Created by phamtu on 09/07/2021.
//

import UIKit

class LocationViewController: UIViewController {
    var listData:[LocationModel] = [LocationModel]()
    func GetLocation(andCompletion completion:@escaping (_ moviesResponse: [LocationModel], _ error: Error?) -> ()) {
        APIService.shared.GetLocation() { (response, error) in
            if let listData = response{
                self.listData = listData
                DispatchQueue.main.async {
                    self.locationTbview.reloadData()
                }
            }
            completion(self.listData, error)
        }
    }
    @IBOutlet weak var locationTbview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        
    }
//MARK:- initTableView
    private func initTableView() {
        locationTbview.register(UINib(nibName: "Charactercell", bundle: nil), forCellReuseIdentifier: "Charactercell")
        locationTbview.delegate = self
        locationTbview.dataSource = self
        self.GetLocation(){_,_ in}
    }
    
}
//MARK:- Extention
extension LocationViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Charactercell", for: indexPath ) as! Charactercell
        cell.lblname.text = "Name : " + listData[indexPath.row].name
        cell.lblgender.text = "Type : " + listData[indexPath.row].type
        cell.lblstatus.text = "Dimension: " + listData[indexPath.row].dimension
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
