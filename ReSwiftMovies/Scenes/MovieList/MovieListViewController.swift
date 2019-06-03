
import UIKit
import ReSwift
import SnapKit
import Alamofire
import AlamofireImage

class MovieListViewController: UIViewController, ViewModelBased, StoreSubscriber {
    
    var viewModel: MoviesListViewModel!
    private var movies = [DiscoverMovieModel]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MovieListViewCell.className, bundle: nil), forCellReuseIdentifier: MovieListViewCell.className)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayouts()
        
        store.dispatch(AppActions.MovieList.startLoadingMovies())
    }
    
    func newState(state: AppState) {
        
        guard state.movieListState.movies.count > 0 else { return }
        
        self.movies = state.movieListState.movies
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    private func configureLayouts() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieListViewCell = tableView.dequeueReusableCell(withIdentifier: MovieListViewCell.className, for: indexPath) as! MovieListViewCell
        let movie = self.movies[indexPath.row]
        cell.title.text = movie.name
        cell.overview.text = movie.overview
        let posterPath = "https://image.tmdb.org/t/p/w154"+movie.posterPath
        Alamofire.request(posterPath).responseImage { (response) in
            guard response.request?.url?.absoluteString == posterPath else { return }
            guard let data = response.data else { return }
            
            cell.poster.image = UIImage(data: data)
        }
        
        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = self.movies[indexPath.row]
        let movieDetailViewModel = MovieDetailViewModel(with: self.viewModel.injectionContainer, withMovieId: movie.id)
        let movieDetailViewController = MovieDetailViewController.instanceFromSB(with: movieDetailViewModel)
        UIApplication.shared.keyWindow?.rootViewController?.present(movieDetailViewController, animated: true)
        
        store.dispatch(AppActions.CheckedMovies.addChecked(movie: movie))
    }
}
