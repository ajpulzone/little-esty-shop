require "./app/poros/holiday"
require "./app/services/nager_services.rb"

class HolidaySearch
  
  def next_3_holidays
    data = service.holiday[:name, :date]
    Holiday.new(data)

  end



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