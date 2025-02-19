defmodule PetRockRental.Items.Item do
  use Ash.Resource,
    otp_app: :pet_rock_rental,
    domain: PetRockRental.Items,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "items"
    repo PetRockRental.Repo
  end

  actions do
    defaults [:read]

    create :create do
      accept [:quantity, :price]
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :quantity, :decimal
    attribute :price, :money
  end

  calculations do
    calculate :total_price, :money, expr(quantity * price)
  end
end
