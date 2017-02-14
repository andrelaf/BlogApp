require 'rails_helper'

RSpec.feature "Showing Articles" do
  
    before do 
      @andre = User.create(email: "andre.amorim.si@gmail.com", password: "balfbgnbw")
      @fred = User.create(email: "fred@example.com", password: "password")
      @article = Article.create(title: "The first article", body: "Body of first article", user: @andre)
    end
    
  scenario "A non-signed in user does not see Edit or Delete links" do
     visit "/" 
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
    
    
  scenario "A non-woner signed in cannot see both links" do
    login_as(@fred)
     
    visit "/" 
    
    click_link @article.title
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
    
  scenario "A signed in owner sees both links" do
    login_as(@andre)
     
    visit "/" 
    
    click_link @article.title
    
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
    
    
  scenario "Display individual article" do
    visit "/" 
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

  end
    
end