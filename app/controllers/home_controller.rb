class HomeController < ApplicationController
  def index
    @secret_posts = SecretPost.published.includes(task: :question_template).order(due_at: :desc).limit(20)
  end
end
