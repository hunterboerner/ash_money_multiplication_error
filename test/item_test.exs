defmodule ItemTest do
  use PetRockRental.DataCase

  test "calculations" do
    item =
      PetRockRental.Item
      |> Ash.Changeset.for_create(:create, %{quantity: 10, price: Money.new(100, :USD)})
      |> Ash.create!()

    assert Money.equal?(Ash.load!(item, [:total_price]).total_price, Money.new(1000, :USD)) ==
             true

    assert Money.equal?(
             Ash.calculate!(PetRockRental.Item, :total_price,
               refs: %{price: Money.new(3, :USD), quantity: 10}
             ),
             Money.new(30, :USD)
           )
  end
end
