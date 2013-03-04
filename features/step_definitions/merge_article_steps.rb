Given /^the blog is set up$/ do
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  admin = User.create!({:login => 'admin',
                :password => 'aaaaaaaa',
                :email => 'joe@snow.com',
                :profile_id => 1, #admin
                :name => 'admin',
                :state => 'active'})

  publisher = User.create!({:login => 'publisher',
                :password => 'aaaaaaaa',
                :email => 'joe2@snow.com',
                :profile_id => 2, #publisher
                :name => 'publisher',
                :state => 'active'})


  article1 = Article.create(:id => 1, :title => "Article 1 title", :body => "article 1 text", :author => admin, :published => false)
  article2 = Article.create(:id => 2, :title => "Article 2 title", :body => "article 2 text", :author => admin, :published => false)
  article3 = Article.create(:id => 3, :title => "Article 3 title", :body => "article 3 text", :author => publisher, :published => false)
end

And /^I am logged as (.*) into the admin panel$/ do |user|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end