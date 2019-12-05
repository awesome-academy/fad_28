namespace :products do
  desc "TODO"
  task close_discount: :environment do
    Product.timeout_discount.update_all discount: nil
  end

  task upto_sold_many: :environment do
    Product.toggle_sold_many.update_all sold_many: true
  end
end
