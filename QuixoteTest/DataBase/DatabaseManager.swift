//
//  DatabaseManager.swift
//  QuixoteTest
//
//  Created by Praful Kharche on 07/04/22.
//

import Foundation
import FMDB

class DatabaseManager: NSObject{
    
    var database:FMDatabase? = nil
    
    static let shared = DatabaseManager()
    //MARK: Initialise
    override init() {
        super.init()
        
        if database == nil{
            database = FMDatabase(path: Util.getPath("Notes.db"))
        }
    }
    
    //MARK: Login Table Insert
    func saveLoginData(_ modelInfo:LoginData) -> Bool{
        database?.open()
        let isSave = database?.executeUpdate("INSERT INTO Login (name,mob,email,password) VALUES (?,?,?,?)", withArgumentsIn: [modelInfo.name,modelInfo.mob,modelInfo.email,modelInfo.password])
        database?.close()
        return isSave!
    }
    
    //MARK: Login Table Fetch
    func getLoginData() -> [LoginData]{
        var loginArray = [LoginData]()//Intialise
        
        guard (database?.open() ?? false) else{
            print("Unable to open database")
            return loginArray
        }
        do {
            let rs = try database?.executeQuery("select * from Login", values: nil)
            
            
            while rs!.next() {
                let item : LoginData = LoginData(name: rs?.string(forColumn: "name") ?? "", mob: rs?.string(forColumn: "mob") ?? "", email: rs?.string(forColumn: "email") ?? "", password: rs?.string(forColumn: "password") ?? "")
                
                
                loginArray.append(item)
            }
            
            rs?.close()
        }
        catch{
            print("error:\(error.localizedDescription)")
        }
        return loginArray
    }
    
    //MARK: Notes Table insert
    func saveData(_ modelInfo:Notes) -> Bool{
        database?.open()
        let isSave = database?.executeUpdate("INSERT INTO Notes (title,description,image) VALUES (?,?,?)", withArgumentsIn: [modelInfo.title,modelInfo.description,modelInfo.image])
        database?.close()
        return isSave!
    }
    
    //MARK: Login Table fetc
    func getAllData() -> [Notes]{
        
        var notesArray = [Notes]()//Intialise
        
        guard (database?.open() ?? false) else{
            print("Unable to open database")
            return notesArray
        }
        do {
            let rs = try database?.executeQuery("select * from Notes", values: nil)
            
            while rs!.next() {
                let item : Notes = Notes(title: rs?.string(forColumn: "title") ?? "", image: rs?.string(forColumn: "image") ?? "", description: rs?.string(forColumn: "description") ?? "")
                
                notesArray.append(item)
            }
            
            rs?.close()
        }
        catch{
            print("error:\(error.localizedDescription)")
        }
        return notesArray
    }
    
    
}
