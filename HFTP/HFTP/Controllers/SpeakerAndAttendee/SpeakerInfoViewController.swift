//
//  SpeakerInfoViewController.swift
//  HFTP
//
//  Created by ny38 on 3/18/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SpeakerInfoViewController: UIViewController {
   

    @IBOutlet weak var sessionIndex: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var avatorImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    var mySpeaker = Speaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = mySpeaker.fullName
        companyLabel.text = mySpeaker.company
        email.text = mySpeaker.email
        
        if(mySpeaker.avator.isEmpty) {
            avatorImage.image = UIImage(named: K.imageName.defaultPhoto)
        } else {
            avatorImage.image = fetchData.stringToImage(mySpeaker.avator)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: K.cellName.sessionInfoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: K.identifiers.cellID)
    }
}



// MARK: - Speaker session information UICollectionView

extension  SpeakerInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mySpeaker.sessions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.identifiers.cellID, for: indexPath) as! SessionInfoCollectionViewCell
        let item = sessionDic[mySpeaker.sessions[indexPath.row]]!
        cell.sessionName.text = item.name
        cell.sessionType.text = item.category
        cell.sessionTime.text = item.date + " " + item.startTime
        cell.sessionLocation.text = item.location
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        sessionIndex.text = "\(indexPath.row + 1)" + "/" + "\(mySpeaker.sessions.count)"
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.height)
    }
    
    @IBAction func leftArrowAction(_ sender: UIButton) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }

    @IBAction func rightArrowAction(_ sender: UIButton) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }

    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    
}
