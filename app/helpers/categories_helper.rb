module CategoriesHelper
  def parent_name_for category
    if category.parent_id?
      category.parent_id
    else
      t ".none"
    end
  end
end
