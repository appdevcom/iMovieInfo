//
//  TableViewController.swift
//  MovieInfo
//
//  Created by Américo Rio on 29/04/2018.
//  Copyright © 2018 Américo Rio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewControllerList: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var search_txt: UITextField!
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblJSON.delegate = self
        tblJSON.dataSource = self
        search_txt.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        
        
        
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ search_txt: UITextField) -> Bool {
        
        // Hide the keyboard.
        search_txt.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ search_txt: UITextField) {
        
        let searchString = search_txt.text!

        let searchUrl = Constants.url + "&s=" + searchString
        
        Alamofire.request(searchUrl).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print (swiftyJsonVar)
                
                if let resData = swiftyJsonVar["Search"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            }
        }
        
 
    }
    


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrRes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath)

         var dict = arrRes[indexPath.row]
         cell.textLabel?.text = dict["Title"] as? String
         cell.detailTextLabel?.text = dict["Year"] as? String

        if let poster = dict["Poster"] as? String{
            print (poster)
            let imageUrl = URL(string: poster)!
            cell.imageView?.af_setImage(withURL: imageUrl)
        }
        

        return cell
    }
    
    

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let ViewControllerDetail = segue.destination as? ViewControllerDetail {
            if let indexPath = self.tblJSON?.indexPathForSelectedRow {
                ViewControllerDetail.imdbID = arrRes[indexPath.row]["imdbID"]! as? String
            }
        }
    }
    

   
}
