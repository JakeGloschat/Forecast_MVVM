//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Jake Gloschat on 3/8/23.
//

import Foundation

protocol DayDetailViewModelDelegate: DayDetailsViewController {
    func updateViews()
}

class DayDetailViewModel {
 
    var forcastData: TopLevelDictionary?
    var days: [Day] {
        forcastData?.days ?? []
    }
    
   private weak var delegate: DayDetailViewModelDelegate?
    
    private let networkingController: NetworkingContoller
    
    init(delegate: DayDetailViewModelDelegate, networkController: NetworkingContoller = NetworkingContoller()) {
        self.delegate = delegate
        self.networkingController = networkController
        fetchForecastData()
    }
    
    private func fetchForecastData() {
        NetworkingContoller.fetchDays { result in
            switch result {
            case .success(let success):
                self.forcastData = success
                self.delegate?.updateViews()
            case .failure(let error):
                print(ResultError.thrownError(error))
            }
        }
    }
    
}
