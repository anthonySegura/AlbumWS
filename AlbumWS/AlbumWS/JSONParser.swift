//
//  JSONParser.swift
//  AlbumWS
//
//  Created by Anthony on 9/7/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation

class JSONParser {
    
    static func parseAlbums(data : NSData) -> [Album] {
        
        var albumsList = [Album]()
        
        do  {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            //Se pasa el JSON a un array
            let albumsArray = json as! NSArray
            
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