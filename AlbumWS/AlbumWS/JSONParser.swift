//
//  JSONParser.swift
//  AlbumWS
//
//  Created by Anthony on 9/7/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation


class JSONParser {
    
    
    //Pasa los datos de un objeto NSData a un arreglo de albums
    static func parseAlbums(data : NSData) -> [Album] {
        
        var albumsList = [Album]()
        
        //Cuerpo de un try catch
        do  {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            //Se pasa el JSON a un array
            let albumsArray = json as! NSArray
            
            //Cada album del arreglo es un diccionario
            for album in albumsArray{
                let albumId = album["id"] as! Int
                let albumTitle = album["title"] as! String
                let newAlbum = Album(id : albumId, titulo: albumTitle)
                albumsList.append(newAlbum)
            }
            
        }
        catch{
            print("Error")
        }
        
        return albumsList
    }
    
}