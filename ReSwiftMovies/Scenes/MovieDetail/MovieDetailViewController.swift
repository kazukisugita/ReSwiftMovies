//
//  MovieDetailViewController.swift
//  RxReduceDemo
//
//  Created by Thibault Wittemberg on 18-06-07.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ReSwift

class MovieDetailViewController: UIViewController, ViewModelBased, StoreSubscriber {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var originalNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MovieDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        store.dispatch(AppActions.MovieDetail.loadDetail(movieID: viewModel.movieId))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        render(state: state)
    }

    private func render (state: AppState) {
        
        guard let movie = state.movieDetailState.movie else { return }
        
        self.activityIndicator.startAnimating()
        var posterPath = "https://image.tmdb.org/t/p/w780"+movie.posterPath
        if let backdropPath = movie.backdropPath {
            posterPath = "https://image.tmdb.org/t/p/w780"+backdropPath
        }
        Alamofire.request(posterPath).responseImage { [weak self] (response) in
            guard response.request?.url?.absoluteString == posterPath else { return }
            guard let data = response.data else { return }

            self?.posterImageView.image = UIImage(data: data)
            self?.activityIndicator.stopAnimating()
        }
        self.nameLabel.text = movie.name
        self.overviewTextView.text = movie.overview
        self.voteAverageLabel.text = "\(movie.voteAverage)"
        self.popularityLabel.text = "\(movie.popularity)"
        self.originalNameLabel.text = movie.originalName
        self.releaseDateLabel.text = movie.releaseDate
    }

    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
