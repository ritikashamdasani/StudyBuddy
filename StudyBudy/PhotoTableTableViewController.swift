//
//  PhotoTableTableViewController.swift
//  StudyBudy
//
//  Created by Apple on 6/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PhotoTableTableViewController: UITableViewController {
    var photos : [Photos] = []
    
    func getPhotos () {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
                photos = coreDataPhotos
                tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPhotos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToDetail", sender: photos[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            if let photoDetailView = segue.destination as? PhotoDetailViewController {
                
                if let photoToSend = sender as? Photos {
                    photoDetailView.photo = photoToSend
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let cellPhoto = photos[indexPath.row]
        cell.textLabel?.text = cellPhoto.caption
        
        if let cellPhotoImageData = cellPhoto.imageData {
            if let cellPhotoImage = UIImage(data: cellPhotoImageData) {
                cell.imageView?.image = cellPhotoImage
            }
        }
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let photoToDelete = photos[indexPath.row]
                
                context.delete(photoToDelete)
                
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getPhotos()
            }
            
        }
    }

    
    
}
