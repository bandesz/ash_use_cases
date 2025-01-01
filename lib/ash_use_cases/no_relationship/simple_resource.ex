defmodule AshUseCases.NoRelationship.SimpleResource do
  use Ash.Resource,
    otp_app: :ash_use_cases,
    domain: AshUseCases.NoRelationship,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "simple_resources"
    repo AshUseCases.Repo
  end

  actions do
    defaults [:read, :destroy, create: [:name, :count], update: [:name, :count]]
  end

  attributes do
    integer_primary_key :id

    attribute :name, :string do
      allow_nil? false
      public? true
    end

    attribute :private_comment, :string do
      sensitive? true
    end

    attribute :count, :integer do
      public? true
    end
  end
end
