describe Loyalty::Data::RollbackCheque do
  describe '#data' do
    it 'returns prepared data' do
      expect(Loyalty::Data::RollbackCheque.new(
        card_number: 31337,
        transaction_id: '1234567890'
      ).data).to eq(
        'Card' => {
          'CardNumber' => 31337
        },
        'TransactionReference' => {
          'TransactionID' => '1234567890'
        },
        'OperationType' => 'Rollback'
      )
    end
  end
end
