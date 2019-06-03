
import UIKit
import Alamofire
import AlamofireImage
import ReSwift

class CheckedMoviesListViewController: UIViewController, StoreSubscriber {
    
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
        
        self.title = "Checked"
        
        configureLayouts()
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
        self.movies = state.checkedMoviesState.movies
        tableView.reloadData()
    }
    
    private func configureLayouts() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}

extension CheckedMoviesListViewController: UITableViewDataSource {
    
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

extension CheckedMoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
