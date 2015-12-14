describe Loyalty::Data::SaleCheque do
  describe '#data' do
    it 'returns prepared data' do
      item1 = Loyalty::Data::SaleChequeItem.new(
        article: 123,
        price: 100.0,
        quantity: 2,
        discount: 0
      )

      item2 = Loyalty::Data::SaleChequeItem.new(
        article: 31337,
        price: 100.0,
        quantity: 4,
        discount: 10
      )

      expect(Loyalty::Data::SaleCheque.new(
        card_number: 31337,
        number: '123123123',
        paid_by_bonus: 0.0,
        items: [item1, item2],
        coupon: 1234
      ).data).to eq(
        'Card' => {
          'CardNumber' => 31337
        },
        'Number' => '123123123',
        'PaidByBonus' => 0.0,
        'Coupons' => {
          'Coupon' => {
            'Number' => 1234
          }
        },
        'Item' => [
          {
            'Article' => 123,
            'Price' => 100.0,
            'Quantity' => 2,
            'Discount' => 0
          },
          {
            'Article' => 31337,
            'Price' => 100.0,
            'Quantity' => 4,
            'Discount' => 10
          },
        ]
      )
    end
  end
end
