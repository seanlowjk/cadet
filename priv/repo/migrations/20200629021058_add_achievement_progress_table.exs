defmodule Cadet.Repo.Migrations.AddAchievementProgressTable do
  use Ecto.Migration

  alias Cadet.Achievements.AchievementProgress

  def change do
    create table(:achievement_progresses) do
      add(:progress, :integer)
      add(:completion_text, :string)
      add(:achievement_id, references(:achievements), null: false)
      add(:student_id, references(:users), null: false)

      timestamps()
    end

    create(unique_index(:achievement_progresses, [:achievement_id, :student_id]))
  end
end
