require "./app/poros/repo"
require "./app/poros/pull_request"
require "./app/services/github_services"

class GithubSearch
  def repo_information
    data = service.repo_name[:name]
    Repo.new(data)
  end

  def service
    GithubService.new
  end

  def contributor_names
    service.contributors.map do |data|
      Contributor.new(data)
    end
  end

  def pull_requests
    data = service.pull_requests[0]
    latest_pull = PullRequest.new(data)
  end
end