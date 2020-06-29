defmodule CadetWeb.AchievementsController do
  
  use CadetWeb, :controller

  use PhoenixSwagger

  alias Cadet.Achievements
  alias Cadet.Achievements.AchievementAbility

  @create_achievement_roles ~w(staff admin)a

  def index(conn, _) do
    achievements = Achievements.all_achievements()

    render(conn, "index.json", achievements: achievements)
  end

  def update(conn, %{"achievements" => achievements}) do
    result = Achievements.update_achievements(achievements)

    case result do
      :ok->
        text(conn, "OK")

      {:error, {status, message}} ->
        conn
        |> put_status(status)
        |> text(message)
    end
  end

  def add(conn, %{"achievement" => achievement}) do
    result = Achievements.add_achievement(achievement)

    case result do
      :ok->
        text(conn, "OK")

      {:error, {status, message}} ->
        conn
        |> put_status(status)
        |> text(message)
    end
  end

  def edit(conn, %{"achievement" => achievement}) do
    result = Achievements.update_achievement(achievement)

    case result do
      :ok->
        text(conn, "OK")

      {:error, {status, message}} ->
        conn
        |> put_status(status)
        |> text(message)
    end
  end

  def delete(conn, %{"achievement" => achievement}) do
    result = Achievements.delete_achievement(achievement)

    case result do
      :ok->
        text(conn, "OK")

      {:error, {status, message}} ->
        conn
        |> put_status(status)
        |> text(message)
    end
  end

  def get_progress(conn, %{"student_id" => student_id}) do
    result = Achievements.get_achievement_progress(student_id)

    case result do
      :ok->
        text(conn, "OK")

      {:error, {status, message}} ->
        conn
        |> put_status(status)
        |> text(message)
    end
  end

  def add_progress(conn, %{"student_id" => student_id, "achieveent_id" => achievement_id}) do
    result = Achievements.add_achievement_progress(student_id, achievement_id)

    case result do
      :ok->
        text(conn, "OK")

      {:error, {status, message}} ->
        conn
        |> put_status(status)
        |> text(message)
    end
  end

  def update_progress(conn, %{"student_id" => student_id, "achieveent_id" => achievement_id, "progress" => progress}) do
    result = Achievements.update_achievement_progress(student_id, achievement_id, progress)

    case result do
      :ok->
        text(conn, "OK")

      {:error, {status, message}} ->
        conn
        |> put_status(status)
        |> text(message)
    end
  end

  swagger_path :index do
    get("/achievements")

    summary("Get list of all achievements")
    security([%{JWT: []}])

    response(200, "OK")
    response(401, "Unauthorised")
  end

  def swagger_definitions do
    %{
      Achievements:
        swagger_schema do
          properties do

            title(
              :string,
              "title of the achievement"
            )

            ability(
              AchievementAbility,
              "ability"
            )

            icon(
              :string,
              "icon name"
            )

            inferencer_id(
              :integer,
              "id used for reference by inferencer"
            )

            exp(
              :integer,
              "exp awarded for the achievement"
            )

            open_at(
              :string,
              "open date of achievement"
            )

            close_at(
              :string,
              "close date of achievement"
            )

            is_task(
              :boolean,
              "if the achievement is a task or not"
            )

            prerequisite_ids(
              :array,
              "id of the prerequisites of the achievement"            
            )

            goal(
              :integer,
              "goal value"
            )


            modal_image_url(
              :string,
              "url of the image for the modal"
            )

            description(
              :string,
              "description of the achievement"            
            )

            goal_text(
              :string,
              "text to reach the goal of the achievement"            
            )
          end
        end
    }
  end

end 