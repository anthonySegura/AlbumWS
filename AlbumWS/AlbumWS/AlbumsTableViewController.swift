//
//  AlbumsTableViewController.swift
//  AlbumWS
//
//  Created by Anthony on 9/7/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    //Arreglo de albums
    
    var tableViewAlbumData = [Album]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: -LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidesWhenStopped = true
        //Conexion con el web service
        connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -WebService connection
    
    
    //Metodo asincrono - Los metodos sincronos congelan la aplicacion
    //La app debe de mostrar que esta cargando
    func connect(){
        
        self.activityIndicator.startAnimating()
        //Direccion del Web Service
        let urlPath : String! = "http://jsonplaceholder.typicode.com/albums"
        let url = NSURL(string: urlPath)
        //Se crea la sesion
        let session = NSURLSession.sharedSession()
        //Se crea la tarea
        let task = session.dataTaskWithURL(url!, completionHandler: {data,
            response, error -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            print(statusCode)
        
        })
        //Se llama la tarea
        task.resume()
        //self.activityIndicator.stopAnimating()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
