//
//  ViewController.swift
//  BrewDog
//
//  Created by Tom Seymour on 11/16/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController {

    
    @IBOutlet weak var beerTableView: UITableView!
    
    let beerEndpoint = "https://api.punkapi.com/v2/beers?page=1&per_page=80"
    var beerList: [Beer] = []
    
    func getData() {
        guard let url = URL(string: beerEndpoint) else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let myError = error {
                print(myError)
                return
            }
            if let myData = data {
                do {
                    guard let beerJSONArray = try JSONSerialization.jsonObject(with: myData, options: []) as? [[String: Any]] else {return}
                    for beerDict in beerJSONArray {
                        if let thisBeer = Beer(from: beerDict) {
                            self.beerList.append(thisBeer)
                        }
                    }
                    DispatchQueue.main.async {
                        self.beerTableView.reloadData()
                    }
                   
                    
                }
                catch {
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        beerTableView.delegate = self
        beerTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

 
    

}
extension BeerViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = beerList[indexPath.row]
        let cell = beerTableView.dequeueReusableCell(withIdentifier: "Beer Cell", for: indexPath)
        cell.textLabel?.text = beer.name
        cell.detailTextLabel?.text = "\(beer.abv)%"
        return cell
    }
}

