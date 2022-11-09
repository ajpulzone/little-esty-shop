class GithubService
  def repos
    get_url("https://api.github.com/users/Freeing3092/repos")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body)
  end
end