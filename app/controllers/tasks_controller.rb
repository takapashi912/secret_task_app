class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :complete, :not_complete ]
  before_action :update_overdue_tasks, only: [ :index ]

  def index
    @tasks = current_user.tasks.order(due_at: :asc)
  end

  def show
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      SecretPost.create!(
      task: @task,
      user: current_user,
      content: @task.secret_content
      )
      redirect_to tasks_path, notice: "タスクを作成しました。"
    else
      flash.now[:error] = @task.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task.secret_content = @task.secret_post.content
  end

  def update
    if @task.update(task_params)
      @task.secret_post.update(
      content: @task.secret_content
      )
      redirect_to @task, notice: "タスクを更新しました。"
    else
      flash.now[:error] = @task.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: "タスクを削除しました。"
  end

  def complete
    if @task.update(status: :completed)
      redirect_to @task, notice: "タスクを達成にしました。"
    else
      redirect_back fallback_location: task_path(@task), alert: "ステータス変更に失敗しました。"
    end
  end

  def not_complete
    if @task.update(status: :not_completed)
      redirect_back fallback_location: task_path(@task), notice: "タスクを未達成にしました。"
    else
      redirect_back fallback_location: task_path(@task), alert: "ステータス変更に失敗しました。"
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :due_at, :question_template_id, :secret_content)
  end

  def update_overdue_tasks
    current_user.tasks.overdue.update_all(status: :not_completed, updated_at: Time.current)
  end
end
