//
//  PlacesViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 12/4/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MBProgressHUD

class PlacesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        observePlaces()
    }
    

    func setupTableView() {
        let cellNib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func observePlaces() {
        let ref = Firestore.firestore().collection("places")
        ref.getDocuments { (snapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            for document in snapshot!.documents {
                let name = document["name"] as! String
                let description = document["description"] as! String
                let imageUrl = document["imageUrl"] as! String
                let url = URL(string: imageUrl)
                ImageService.getImage(withUrl: url!) { (image) in
                    if let image = image {
                        self.places.append(Place(name: name, description: description, image: image))
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlaceDescriptionVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                var viewController = segue.destination as! PlaceDescriptionViewController
                viewController.place = places[indexPath.row]
            }
        }
    }

}

// MARK: - Table view delegates
extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! PlaceTableViewCell
        cell.set(place: places[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPlaceDescriptionVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
