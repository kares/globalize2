ActiveRecord::Schema.define do
  
  create_table :blogs, :force => true do |t|
  end

  create_table :posts, :force => true do |t|
    t.references :blog
  end

  create_table :post_translations, :force => true do |t|
    t.string     :locale
    t.references :post
    t.string     :subject
    t.text       :content
  end
  
  create_table :comments, :force => true do |t|
    t.references :post
  end

  create_table :bot_comment_translations, :force => true do |t|
    t.string     :locale
    t.references :comment
    t.string     :subject
    t.text       :content
  end
  
end
  
