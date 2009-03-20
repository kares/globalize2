require File.join( File.dirname(__FILE__), '..', '..', 'test_helper' )
require 'active_record'
require 'globalize/model/active_record'

# Hook up model translation
ActiveRecord::Base.send(:include, Globalize::Model::ActiveRecord::Translated)

# Load Post and Comment model
require File.join( File.dirname(__FILE__), '..', '..', 'data', 'post' )
require File.join( File.dirname(__FILE__), '..', '..', 'data', 'comment' )

class TranslatedSubclassTest < ActiveSupport::TestCase
  
  def setup
    I18n.locale = :'en-US'
    I18n.fallbacks.clear 
    reset_db! File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'data', 'schema.rb'))
    ActiveRecord::Base.locale = nil
    @post = Post.create :subject => 'a post'
  end
  
  def teardown
    I18n.fallbacks.clear 
  end
  
  test "has bot_comment_translations" do
    bot_comment = BotComment.create(:post => @post)
    # if the :foreign_key option on has_many is left out this will fail :
    assert_nothing_raised { bot_comment.globalize_translations }
  end

  test "does no have comment_translations" do
    bot_comment = BotComment.create(:post => @post)
    # if the :foreign_key option on has_many is left out this will fail :
    assert_nothing_raised { bot_comment.globalize_translations }
  end
  
  test "modifiying translated fields while switching locales" do
    bot_comment = BotComment.create(:post => @post, :body => 'foo')
    assert_equal 'foo', bot_comment.body
    I18n.locale = :'de-DE'
    bot_comment.body = 'bar'
    assert_equal 'bar', bot_comment.body
    I18n.locale = :'en-US'
    assert_equal 'foo', bot_comment.body
  end
  
  test "has german bot_comment_translations" do
    I18n.locale = :de
    bot_comment = BotComment.create(:post => @post, :body => 'foo')
    assert_equal 1, bot_comment.globalize_translations.size
    I18n.locale = :en
    assert_equal 1, bot_comment.globalize_translations.size    
  end
  
end

