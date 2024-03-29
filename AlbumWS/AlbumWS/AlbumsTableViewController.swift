//
//  AlbumsTableViewController.swift
//  AlbumWS
//
//  Created by Anthony on 9/7/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit


//Controlador del tableView de albums
class AlbumsTableViewController: UITableViewController {
    
    //Arreglo de albums
    var tableViewAlbumData = [Album]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: -LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Constants.ALBUMS_TITLE
        //Conexion con el web service
        connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -WebService connection
    
    
    //Realiza la conexion con el WebService
    //Metodo asincrono - Los metodos sincronos congelan la aplicacion!
    //La app debe mostrar que esta cargando
    func connect(){
        
        self.activityIndicator.startAnimating()
        
        //Direccion del Web Service
        let urlPath : String! = Constants.BASE_URL + Constants.ALBUMS
        let url = NSURL(string: urlPath)
        //Se crea la sesion
        let session = NSURLSession.sharedSession()
        //Se crea la tarea
        let task = session.dataTaskWithURL(url!, completionHandler: {data,
            response, error -> Void in
            //Cuerpo de la funcion anonima
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            /*
            Convertir los datos a string
            let convertedString = NSString(data : data!, encoding: NSUTF8StringEncoding)
            */
            
            if statusCode == Constants.STATUS_OK {
                //Como este metodo es asincrono se tiene que llamar esto para hacer cambios en el hilo principal
                dispatch_async(dispatch_get_main_queue()){
                    //Se cargan los datos en el tableView
                    self.setTableView(JSONParser.parseAlbums(data!))
                }
                
            }
            
        })
        //Se llama la tarea
        task.resume()
        
    }
    
    //MARK: - UI Methods
    
    
    //Carga los datos de los albums desde el WebService
    func setTableView(albumsData : [Album]){
        
        tableViewAlbumData = albumsData
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
        //Se actualizan las celdas del tableView
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableViewAlbumData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let album = self.tableViewAlbumData[indexPath.row]
        cell.textLabel?.text = album.titulo
        return cell
    }
    
    

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
