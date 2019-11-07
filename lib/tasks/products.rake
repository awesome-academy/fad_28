namespace :products do
  desc "TODO"
  task close_discount: :environment do
    Product.timeout_discount.update_all discount: nil
  end
end
