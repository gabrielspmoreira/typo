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


  #@article1 = Factory(:article, :title => 'Artigo 1', :body => 'Este e o artigo 1', :author => admin)
  @article1 = Article.create!(:title => 'Artigo 1', :body => 'Este e o artigo 1', :author => admin, :published => true)
  #@article2 = Factory(:article, :title => 'Artigo 2', :body => 'Este e o artigo 2', :author => publisher)
  @article2 = Article.create!(:title => 'Artigo 2', :body => 'Este e o artigo 2', :author => publisher, :published => true)
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

When /^I merge two articles$/ do
  @new_article = @article1.merge_with(@article2.id)
end

Then /^new article should have text from both articles$/ do
  @new_article.body.should include(@article1.body)
  @new_article.body.should include(@article2.body)
end

Then /^new article should have one author$/ do
  @new_article.author.should == @article1.author
end

Then /^new article should have all comments from original articles$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the title of new article should contain original articles title$/ do
  @new_article.title.should include(@article1.title)
  @new_article.title.should include(@article2.title)
end
