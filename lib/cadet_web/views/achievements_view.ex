defmodule CadetWeb.AchievementsView do
  use CadetWeb, :view
  use Timex

  def render("index.json", %{achievements: achievements}) do
    render_many(achievements, CadetWeb.AchievementsView, "overview.json", as: :achievement)
  end

  def render("overview.json", %{achievement: achievement}) do
    transform_map_for_view(achievement, %{
      inferencer_id: :inferencer_id, 
      id: :id,
      title: :title,
      ability: :ability, 
      icon: :icon,
      exp: :exp,
      openAt: &format_datetime(&1.open_at),
      closeAt: &format_datetime(&1.close_at),
      isTask: :is_task, 
      prerequisiteIds: :prerequisite_ids, 
      goal: :goal, 

      modalImageUrl: :modal_image_url, 
      description: :description, 
      goalText: :goal_text
    })
  end

  def render("progress.json", %{achievement_progresses: achievement_progresses}) do
    render_many(achievement_progresses, CadetWeb.AchievementsView, "progress_entry.json", as: :achievement_progress)
  end 

  def render("progress_entry.json", %{achievement_progress: achievement_progress}) do
    transform_map_for_view(achievement_progress, %{
      completion_text: :completion_text, 
      progress: :progress, 

      achievement_id: :achievement_id, 
      student_id: :student_id
    })
  end 
end
