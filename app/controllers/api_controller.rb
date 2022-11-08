require 'net/https'
require 'JSON'

class ApiController < ApplicationController
  def index
    base = 'https://api.github.com/users/'
    username = 'freeing3092'
    uri = URI("#{base}#{username}")
    @data = Net::HTTP.get(uri)
    @data = JSON.parse(@data)
    repo_uri = URI(@data['repos_url'])
    @repo_data = Net::HTTP.get(repo_uri)
    @repo_data = JSON.parse(@repo_data)
    @project_repo = @repo_data.find { |x| x['name'] == 'little-esty-shop' }
  end
end
