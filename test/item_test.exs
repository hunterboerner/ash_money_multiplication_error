defmodule ItemTest do
  use PetRockRental.DataCase

  test "calculations" do
    item =
      PetRockRental.Items.Item
      |> Ash.Changeset.for_create(:create, %{quantity: 10.1, price: Money.new(100, :USD)})
      |> Ash.create!()

    assert Money.equal?(Ash.load!(item, [:total_price]).total_price, Money.new(1010, :USD)) ==
             true

    assert Money.equal?(
             Ash.calculate!(PetRockRental.Items.Item, :total_price,
               refs: %{price: Money.new(3, :USD), quantity: Decimal.new("10")}
             ),
             Money.new(30, :USD)
           )
  end
end
