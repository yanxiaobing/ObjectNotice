//
//  ObjectNotice.swift
//  ObjectNoticeDemo
//
//  Created by xbingo on 2020/3/9.
//  Copyright © 2020 Xbingo. All rights reserved.
//

import UIKit

extension NSObject {
    
    var className : String{
        get{
            return type(of: self).description()
        }
    }
    
    var objectIdentifier : String{
        get{
            return String(format:"%@%p", self.className,self)
        }
    }
}

public class ObjectNotice {
    
    public static let shared = ObjectNotice()
    
    public typealias NoticeBlock = (_ object:Any? ,_ userInfo:[AnyHashable:Any]?)->()
    
    private var blockMap : [String : [[String:NoticeBlock]]]
    
    private init(){
        blockMap = [String : [[String:NoticeBlock]]]()
    }
    
    
    public func post(_ name : String) {
        post(name, nil, nil)
    }
    
    public func post(_ name : String , _ object : Any?) {
        post(name, object, nil)
    }
    
    public func post(_ name : String , _ object : Any?, _ userInfo:[AnyHashable : Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name), object: object, userInfo: userInfo)
    }
    
    public func observer(_ observer : NSObject , _ name : String ,_ block : @escaping NoticeBlock) {
        if !blockMap.keys.contains(name) {
            NotificationCenter.default.addObserver(self, selector: #selector(dealWithNotice(_:)), name: NSNotification.Name(name), object: nil)
        }
        
        guard var blockList = blockMap[name] else {
            blockMap[name] = [[observer.objectIdentifier:block]]
            return
        }
        
        var exists = false
        for obj in blockList {
            if obj.keys.contains(observer.objectIdentifier){
                exists = true
                break
            }
        }
        if !exists {
            blockList.append([observer.objectIdentifier:block])
            blockMap[name] = blockList
        }
    }
    
    public func removeObserver(_ observer : NSObject) {
        var map = blockMap
        map.forEach { (name, blockList) in
            var temList = blockList
            for idx in 0..<blockList.count {
                let info = blockList[idx]
                if info.keys.first == observer.objectIdentifier {
                    temList.remove(at: idx)
                    if temList.count > 0 {
                        blockMap[name] = temList
                    }else{
                        map.removeValue(forKey: name)
                        blockMap = map
                        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(name), object: nil)
                    }
                }
            }
        }
    }
    
    @objc func dealWithNotice(_ notice : NSNotification) {
        let blockList = blockMap[notice.name.rawValue]
        blockList?.forEach({ (keyBlock) in
            guard let block = keyBlock.values.first else{
                return
            }
            DispatchQueue.main.async{
                block(notice.object,notice.userInfo)
            }
        })
    }
}
