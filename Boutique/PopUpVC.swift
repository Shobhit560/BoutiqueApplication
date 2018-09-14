//
//  PopUpVC.swift
//  Boutique
//
//  Created by Shobhit Saxena on 05/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit

protocol ClassPopUpVCDelegate: class {
    func btnDoneClicked(str: String, index: Int, selectedRow: Int)
}

class OptionCell: UICollectionViewCell{
    
    @IBOutlet var imgCheckBox: UIImageView!
    @IBOutlet var lblDescription: UILabel!
}
class PopUpVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    var selectedIndex = -1
    var selectedItem = ""
    var isDoneAnything = false
    var pageArray = NSArray()
//    var preSelectedString = ""
    var pageId = -1
    
    weak var delegatePop: ClassPopUpVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OptionCell
        if pageId == 2{
            cell?.lblDescription.text = ((pageArray.object(at: indexPath.row) as! String).components(separatedBy: "$#$"))[0]
        }else{
            cell?.lblDescription.text = (pageArray.object(at: indexPath.row) as! String)
        }
        
        if (selectedIndex == indexPath.row) || (cell?.lblDescription.text == selectedItem){            
            cell?.imgCheckBox.image = #imageLiteral(resourceName: "checkbox_grey")
        }else{
            cell?.imgCheckBox.image = #imageLiteral(resourceName: "checkbox_empty")
        }
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = (pageArray.object(at: indexPath.row) as! String)
        selectedIndex = indexPath.row
        isDoneAnything = true
        collectionView.reloadData()
    }
    @IBAction func btnDone(_ sender: Any) {
        if isDoneAnything == true{
            if selectedItem != ""{
                delegatePop?.btnDoneClicked(str: selectedItem, index: pageId, selectedRow: selectedIndex)
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            delegatePop?.btnDoneClicked(str: "", index: 100, selectedRow: 100)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        delegatePop?.btnDoneClicked(str: "", index: 100, selectedRow: 100)
        self.dismiss(animated: true, completion: nil)
    }
}
