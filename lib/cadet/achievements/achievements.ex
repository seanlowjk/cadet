defmodule Cadet.Achievements do
  @moduledoc """
  The Achievement entity stores metadata of a students' assessment
  """
  
  use Cadet, [:context, :display]

  alias Cadet.Accounts.User
  alias Cadet.Achievements.{Achievement, AchievementProgress}

  import Ecto.Query

  def all_achievements() do
    Cadet.Repo.all(Achievement)
  end 

  def update_achievements(new_achievements) do 
    Cadet.Repo.delete_all(Achievement)

    for new_achievement <- new_achievements do
      add_achievement(new_achievement)
    end 

    :ok
  end 

  def add_achievement(new_achievement) do 
    Cadet.Repo.insert(
      %Achievement{
        inferencer_id: new_achievement["id"], 
        title: new_achievement["title"],
        ability: new_achievement["ability"], 
        exp: new_achievement["exp"],
        is_task: new_achievement["isTask"], 
        prerequisite_ids: new_achievement["prerequisiteIds"], 
        goal: new_achievement["completionGoal"], 
  
        modal_image_url: new_achievement["modal"]["modalImageUrl"], 
        description: new_achievement["modal"]["description"], 
        goal_text: new_achievement["modal"]["goalText"]
      }
    )

    :ok
  end 

  def get_achievement_progress(student_id) do
    Cadet.Repo.all(from progress in AchievementProgress, where progress.student_id == ^student_id)
  end

  def add_achievement_progress(user_id, achievement_id) do
    Cadet.Repo.insert(
      %Achievement{
        student: user_id
        achievement: achievement_id
      )
    )

    :ok
  end

  def update_achievement_progress(user_id, achievement_id, progress_params) do
    from(achievement_progress in AchievementProgress, 
      where: achievement_progress.student_id == ^user_id 
      and achievement_progress.achievement_id == ^achievement_id )
      |>  Cadet.Repo.update_all(
        set: [
          progress: achievement_progress["progress"]
          completion_text: achievement_progress["completionText"]
        ]
      )

    :ok
  end

  def update_achievement(new_achievement) do 
    from(achievement in Achievement, where: achievement.inferencer_id == ^new_achievement["id"])
      |>  Cadet.Repo.update_all(
        set: [
          inferencer_id: new_achievement["id"], 
          title: new_achievement["title"],
          ability: new_achievement["ability"], 
          exp: new_achievement["exp"],
          is_task: new_achievement["isTask"], 
          prerequisite_ids: new_achievement["prerequisiteIds"], 
          goal: new_achievement["completionGoal"], 
    
          modal_image_url: new_achievement["modal"]["modalImageUrl"], 
          description: new_achievement["modal"]["description"], 
          goal_text: new_achievement["modal"]["goalText"]
        ]
      )

    :ok
  end 

  def delete_achievement(new_achievement) do
    from(achievement in Achievement, where: achievement.inferencer_id == ^new_achievement["id"])
      |> Cadet.Repo.delete_all
    :ok
  end 

end

