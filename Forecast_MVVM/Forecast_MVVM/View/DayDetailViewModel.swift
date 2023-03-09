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
    var service: ForecastServiceable
    
    init(delegate: DayDetailViewModelDelegate, forecastServiceable: ForecastServiceable = ForecastService()) {
        self.delegate = delegate
        self.service = forecastServiceable
        self.fetchForecastData()
    }
    
    private func fetchForecastData() {
        service.fetchDays(with: .cityForecast ) { result in
            switch result {
            case .success(let success):
                self.forcastData = success
                self.delegate?.updateViews()
            case .failure(let error):
                print(NetworkError.thrownError(error))
            }
        }
    }
}
