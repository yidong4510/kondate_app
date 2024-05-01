require 'net/http'
require 'json'

class RakutensController < ApplicationController
  def index
  end

  def fetch_recipe
    uri = URI("https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?format=json&formatVersion=2&applicationId=1057932950922970227")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      result = JSON.parse(response.body)
      @random_recipe = result["result"].sample
      render :index
    end
  end

  private
  def set_recipe
    fetch_recipe
  end
end
