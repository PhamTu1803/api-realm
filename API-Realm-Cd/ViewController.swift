//
//  ViewController.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var indexSelectTabSegment = 0
    var listData:[CharacterModel] = [CharacterModel]()
    var lislocation:[LocationModel] = [LocationModel]()
    var listEpisode:[EpisodeModel] = [EpisodeModel]()
    func getCharacter(andCompletion completion:@escaping (_ moviesResponse: [CharacterModel], _ error: Error?) -> ()) {
        APIService.shared.GetCharacter() { (response, error) in
            if let listData = response{
                self.listData = listData
                DispatchQueue.main.async {
                    self.clvcharacter.reloadData()
                }
            }
            completion(self.listData, error)
        }
    }
    func GetLocation(andCompletion completion:@escaping (_ moviesResponse: [LocationModel], _ error: Error?) -> ()) {
        APIService.shared.GetLocation() { (response, error) in
            if let listLocation = response{
                self.lislocation = listLocation
                DispatchQueue.main.async {
                    self.clvcharacter.reloadData()
                }
            }
            completion(self.lislocation, error)
        }
    }
    func getEpisode(andCompletion completion:@escaping (_ moviesResponse: [EpisodeModel], _ error: Error?) -> ()) {
        APIService.shared.GetEpisode() { (response, error) in
            if let listEpisode = response{
                self.listEpisode = listEpisode
                DispatchQueue.main.async {
                    self.clvcharacter.reloadData()
                }
            }
            completion(self.listEpisode, error)
        }
    }

    @IBOutlet weak var choisesegment: UISegmentedControl!
    @IBOutlet weak var clvcharacter: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initColectionView()
    }
    //MARK:-initTableView
    private func initColectionView() {
        clvcharacter.register(UINib(nibName: "allColectionViewCell", bundle: nil), forCellWithReuseIdentifier: "allColectionViewCell")
        clvcharacter.delegate = self
        clvcharacter.dataSource = self
        self.getCharacter(){_,_ in}
    }

    @IBAction func segmentbt(_ sender: UISegmentedControl) {
        if choisesegment.selectedSegmentIndex == 0 {
            indexSelectTabSegment = 0
            self.getCharacter(){_,_ in}
            self.clvcharacter.reloadData()
            }
        if choisesegment.selectedSegmentIndex == 1 {
            
            listData.removeAll()
            indexSelectTabSegment = 1
            self.GetLocation(){_,_ in}
            self.clvcharacter.reloadData()
            }
        if choisesegment.selectedSegmentIndex == 2 {
            
            lislocation.removeAll()
            indexSelectTabSegment = 2
            self.getEpisode(){_,_ in}
            self.clvcharacter.reloadData()
            }
        }
    }
//MARK:- Extention
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if indexSelectTabSegment == 0 {
            return listData.count
        }
        if indexSelectTabSegment == 1 {
            return lislocation.count
        }
        if indexSelectTabSegment == 2 {
            return listEpisode.count
        }
        return listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allColectionViewCell", for: indexPath) as! allColectionViewCell
        cell.backgroundColor = .green
        if self.indexSelectTabSegment == 0 {
            cell.img.isHidden = false
        cell.lnlname.text = "Name : " + listData[indexPath.row].name
        cell.lblstatus.text = "Gender : " + listData[indexPath.row].gender
        cell.lblspecies.text = "Status : " + listData[indexPath.row].status
            if let url = URL(string: listData[indexPath.row].image ?? ""){
                let processor = DownsamplingImageProcessor(size:  cell.img.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 20)

                cell.img.kf.indicatorType = .activity
                cell.img.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }
        return cell
        }
        if self.indexSelectTabSegment == 1 {
            cell.img.isHidden = true
        cell.lnlname.text = "Name : " + lislocation[indexPath.row].name
        cell.lblstatus.text = "Type : " + lislocation[indexPath.row].type
        cell.lblspecies.text = "Dimension : " + lislocation[indexPath.row].dimension
        return cell
        }
        if self.indexSelectTabSegment == 2 {
            cell.img.isHidden = true
        cell.lnlname.text = "Name : " + listEpisode[indexPath.row].name
        cell.lblstatus.text = "Air date : " + listEpisode[indexPath.row].air_date
        cell.lblspecies.text = "Episode : " + listEpisode[indexPath.row].episode
        return cell
        }
        cell.lnlname.text = "Name : " + listData[indexPath.row].name
        cell.lblstatus.text = "Gender : " + listData[indexPath.row].gender
        cell.lblspecies.text = "Status : " + listData[indexPath.row].status
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 15, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
