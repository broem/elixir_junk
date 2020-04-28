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
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Created")
                |> redirect(to: Routes.topic_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "Error")
                render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => topic_id}) do
        topic = Discuss.Repo.get(Topic, topic_id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic
    end

    def update(conn, %{"id" => topic_id, "topic" => topic}) do
        # old_topic = Discuss.Repo.get(Topic, topic_id)
        # changeset = Topic.changeset(old_topic, topic)

        changeset = Discuss.Repo.get(Topic, topic_id) |> Topic.changeset(topic)

        case Discuss.Repo.update(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Updated")
                |> redirect(to: Routes.topic_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "Error")
                render conn, "edit.html", changeset: changeset
        end
    end
end
