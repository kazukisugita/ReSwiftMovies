//
//  MovieDetailViewModel.swift
//  RxReduceDemo
//
//  Created by Thibault Wittemberg on 18-06-07.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailViewModel: ViewModel, Injectable {
    typealias InjectionContainer = HasStore
    var injectionContainer: InjectionContainer
    
    let movieId: Int

    init(with injectionContainer: InjectionContainer, withMovieId movieId: Int) {
        self.injectionContainer = injectionContainer
        self.movieId = movieId
    }
}
