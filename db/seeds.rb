# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

question_bodies = [
  "学生時代にやらかした黒歴史は？",
  "初恋の相手はどんな人？",
  "人生で一番恥ずかしかった瞬間は？",
  "職場でやらかしてしまった、今なら笑える失敗は？"
]

question_bodies.each do |body|
  # 同じ body があれば作らない（デプロイのたびに重複しないように）
  QuestionTemplate.find_or_create_by!(body: body)
end
