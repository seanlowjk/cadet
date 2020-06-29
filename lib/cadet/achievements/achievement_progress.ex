defmodule Cadet.Achievements.AchievementProgress do
  @moduledoc """
  The Achievement entity stores metadata of a students' progress with regards to a particular achievement 
  """
  use Cadet, :model
  use Arc.Ecto.Schema

  alias Cadet.Achievements.Achievement
  alias Cadet.Accounts.User

  schema "achievement_progresses" do
    field(:progress, :integer, default: 0)
    field(:completion_text, :string, default: "Sample Completion Text")

    belongs_to(:achievement, Achievement)
    belongs_to(:student, User)

    timestamps()

    @required_fields ~w(progress completion_text achievement_id student_id)a
  end

  def changeset(achievement_progress, params) do
    achievement_progress
    |> cast(params, @required_fields)
    |> validate_number(
      :progress,
      greater_than_or_equal_to: 0
    )
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:student_id)
    |> foreign_key_constraint(:achievement_id)
  end 
end 