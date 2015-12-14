module Loyalty
  class LoyaltyService
    module Operations
      def sale(sale_cheque:)
        cheque = prepare_cheque('Sale', sale_cheque)
        cheque_request(type: 'Soft', cheque: cheque)
        cheque_request(type: 'Fiscal', cheque: cheque)
      end

      def return(sale_cheque:, receipt_uuid:)
        cheque = prepare_cheque('Return', sale_cheque, receipt_uuid)
        cheque_request(type: 'Fiscal', cheque: cheque)
      end

      def rollback(card_number:, transaction_id:)
        rollback_cheque = Loyalty::Data::RollbackCheque.new(
          card_number: card_number,
          transaction_id: transaction_id
        )
        cheque_request(type: 'Fiscal', cheque: rollback_cheque)
      end

      private

      def prepare_cheque(operation_type, sale_cheque, return_receipt_number = nil)
        cheque_items = sale_cheque.data['Item'].map.with_index do |item, index|
          discounted = (item['Price'].to_f * (1 - (item['Discount'].to_f / 100))).round(2)

          Loyalty::Data::ChequeItem.new(
            position_number: index + 1,
            article: item['Article'],
            price: item['Price'],
            quantity: item['Quantity'],
            discount: item['Discount'],
            summ: item['Price'].to_f * item['Quantity'].to_f,
            summ_discounted: item['Quantity'].to_f * discounted
          )
        end

        sale_cheque = sale_cheque.data
        if cheque_items.empty?
          summ = 0
          summ_discounted = 0
          discount = 0
        else
          summ = cheque_items.map { |item| item.data['Summ'].to_f }.inject(:+)
          summ_discounted = cheque_items.map { |item| item.data['SummDiscounted'].to_f }.inject(:+)
          discount = ((1 - summ_discounted / summ) * 100).round(2)
        end
        Loyalty::Data::Cheque.new(
          card_number: sale_cheque['Card']['CardNumber'],
          number: sale_cheque['Number'],
          operation_type: operation_type,
          summ: summ,
          summ_discounted: summ_discounted,
          discount: discount,
          paid_by_bonus: sale_cheque['PaidByBonus'],
          items: cheque_items,
          coupon: sale_cheque['Coupons'] ? sale_cheque['Coupons']['Coupon']['Number'] : nil,
          return_receipt_number: return_receipt_number
        )
      end
    end
  end
end
