defmodule AshUseCases.NoRelationship do
  use Ash.Domain

  resources do
    resource AshUseCases.NoRelationship.SimpleResource
  end
end
