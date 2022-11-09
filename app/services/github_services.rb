require "httparty"

class GithubService
  def repo_name
    get_url("https://api.github.com/repos/freeing3092/little-esty-shop")
  end

  def contributors
    get_url("https://api.github.com/repos/freeing3092/little-esty-shop/contributors")
  end

  def pull_requests
    get_url("https://api.github.com/repos/freeing3092/little-esty-shop/pulls?state=all")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end