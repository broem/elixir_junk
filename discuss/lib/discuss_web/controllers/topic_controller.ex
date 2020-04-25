defmodule DiscussWeb.TopicController do
    use DiscussWeb, :controller

    alias DiscussWeb.Topic

    def index(conn, _params) do
        # get junk from pg
        topics = Discuss.Repo.all(Topic)
        render conn, "index.html", topics: topics
    end

    def new(conn, _params) do
        # IO.puts "Yoyoyo"
        # IO.inspect conn
        # IO.puts "-----------"
        # IO.inspect params
        changeset = Topic.changeset(%Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic}) do
        # %{"topic" => topic} = params
        changeset = Topic.changeset(%Topic{}, topic)

        case Discuss.Repo.insert(changeset) do
            {:ok, post} ->
                conn
                |> put_flash(:info, "Topic Created")
                |> redirect(to: Routes.topic_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "Error")
                render conn, "new.html", changeset: changeset
        end
    end
end
