defmodule PetRockRental.Items do
  use Ash.Domain,
    otp_app: :pet_rock_rental

  resources do
    resource PetRockRental.Items.Item
  end
end
