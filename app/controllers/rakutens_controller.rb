class RakutensController < ApplicationController
  def index
    client = HTTPClient.new()
    # 楽天レシピカテゴリー一覧API
    res = client.get("https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?format=json&applicationId=#{ENV['RAKUTEN_APPLICATION_ID']}")
    categories = JSON.parse(res.body)["result"]["small"]
    @hit = true
    if params[:search].present?
      # categoryNameの中で検索したワードが入っているカテゴリーを配列として取得する
      categories_list = categories.select{|x| x["categoryName"].include?(params[:search]) }
      if categories_list.empty?
        @hit = false
      else
        # 取得した配列の中からランダムで1つを抽出し、そのカテゴリーIDを取得している
        categorie_id = categories_list.sample["categoryUrl"].split("/").last
        # 取得したカテゴリーIDからそのカテゴリーの中の人気料理を取得している（楽天レシピカテゴリー別ランキングAPI）
        categories_ranktop = client.get("https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=#{ENV['RAKUTEN_APPLICATION_ID']}&categoryId=#{categorie_id}")
        # 取得した料理を8種の形にする
        @foods = JSON.parse(categories_ranktop.body)["result"]
      end
    else
      # 何も検索欄に書かれていない時、人気料理を表示する
      pop = client.get("https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=#{ENV['RAKUTEN_APPLICATION_ID']}&categoryId=30")
      @foods = JSON.parse(pop.body)["result"]
    end
  end
end
