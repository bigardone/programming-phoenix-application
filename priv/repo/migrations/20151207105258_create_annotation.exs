defmodule Rumbl.Repo.Migrations.CreateAnnotation do
  use Ecto.Migration

  def change do
    create table(:annotations) do
      add :user_id, references(:users), null: false
      add :video_id, references(:videos), null: false
      add :body, :text
      add :at, :integer

      timestamps
    end
    create index(:annotations, [:user_id])
    create index(:annotations, [:video_id])

  end
end
