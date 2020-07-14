//
//  ViewController.swift
//  Example
//
//  Created by jiaxin on 2020/7/14.
//  Copyright © 2020 jiaxin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let basicModel = BasicDataModel(JSON: [String : Any]())!
        basicModel.normalFloat = 99.9
        basicModel.normalInt = 9
        basicModel.normalString = "normal_string"

        let normalModel = BasicInfoModel(JSON: [String : Any]())!
        normalModel.id = 33
        normalModel.name = "normal_model"
        let statusModel = BasicInfoStatusModel(JSON: [String : Any]())!
        statusModel.status = 1
        statusModel.info = "状态"
        normalModel.statusList = [statusModel]
        basicModel.normalModel = normalModel

        basicModel.intArray = [1, 2, 3]
        basicModel.stringArray = ["a", "b", "c"]
        basicModel.modelArray = [normalModel]

        basicModel.intStringDict = [1 : "a", 2 : "b", 3 : "c"]
        basicModel.stringModelDict = ["a" : normalModel]

        try? BasicDAO.createTable()
        try? BasicDAO.insertEntity(basicModel)
        if let models = try? BasicDAO.queryRows() {
            print(models.first!)
        }
    }


}

