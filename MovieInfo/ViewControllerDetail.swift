//
//  ViewControllerDetail.swift
//  MovieInfo
//
//  Created by Américo Rio on 30/04/2018.
//  Copyright © 2018 Américo Rio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewControllerDetail: UIViewController {

    var imdbID: String!
    
    //MARK : fiels
    @IBOutlet weak var title_lbl: UILabel!

    @IBOutlet weak var poster_iv: UIImageView!
    
    @IBOutlet weak var description_short_lbl: UILabel!
    @IBOutlet weak var description_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print (imdbID!)
        
        let searchUrl = Constants.url + "&i=" + imdbID!
        
        Alamofire.request(searchUrl).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let row = JSON(responseData.result.value!)
                print (row)
                
                
                
                self.title_lbl.text = row["Title"].string
                
                var desc_short = "Year: " + row["Year"].string!
                desc_short += "\nRated: " + row["Rated"].string!
                desc_short += "\nIMDB: " + row["imdbRating"].string!
                desc_short += "\nGenre: " + row["Genre"].string!
                
                self.description_short_lbl.text = desc_short
                self.description_short_lbl.sizeToFit()
                
                var desc =  "\nActors: " + row["Actors"].string!
                desc += "\nDirector: " + row["Director"].string!
                

                desc += "\n\n" + row["Plot"].string!
                self.description_lbl.text = desc
                self.description_lbl.sizeToFit()
                
                if let poster = row["Poster"].string {
                    print (poster)
                    let imageUrl = URL(string: poster)!
                    self.poster_iv?.af_setImage(withURL: imageUrl)
                }
 
            }
        }
        
        
        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
