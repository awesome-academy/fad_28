every 1.day, at: "0:00am" do
  rake "products:close_discount"
  rake "products:upto_sold_many"
end
